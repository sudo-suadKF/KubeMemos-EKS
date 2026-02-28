resource "aws_eks_cluster" "my-eks-cluster" {
  name                      = var.eks-cluster-name
  role_arn                  = aws_iam_role.my-cluster-iam-role.arn
  version                   = var.k8s-version
  enabled_cluster_log_types = var.cluster-log-types

  access_config {
    authentication_mode                         = var.auth-mode
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids              = var.public-subs-id
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = [var.internet-cidr]
  }

  encryption_config {
    provider {
      key_arn = aws_kms_key.eks-encrypt.arn
    }
    resources = [var.secrets]
  }

  depends_on = [
    aws_iam_role_policy_attachment.policy-role-attach,
  ]
}

resource "aws_kms_key" "eks-encrypt" {
  description             = var.kms-eks-description
  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.aws-account-id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "eks_secrets" {
  name          = var.kms-alias-eks-name
  target_key_id = aws_kms_key.eks-encrypt.id
}

resource "aws_eks_addon" "my-addons" {
  count = length(var.addons)

  cluster_name = aws_eks_cluster.my-eks-cluster.name
  addon_name   = var.addons[count.index]

}

resource "aws_iam_role" "my-cluster-iam-role" {
  name = var.eks-cluster-iam-role-name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy-role-attach" {
  policy_arn = var.eks-cluster-policy-arn
  role       = aws_iam_role.my-cluster-iam-role.name
}

resource "aws_eks_node_group" "my-node-group" {
  cluster_name    = aws_eks_cluster.my-eks-cluster.name
  node_group_name = var.node-group-name
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids      = var.private-subs-id

  scaling_config {
    desired_size = var.desired-size
    max_size     = var.max-size
    min_size     = var.min-size
  }

  update_config {
    max_unavailable = var.max-unavailable
  }
}

resource "aws_iam_role" "node-group-role" {
  name = var.node-group-iam-role-name
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-node-policies-attach" {
  for_each = toset([
    var.eks-worker-node-policy-arn,
    var.eks-cni-policy-arn,
    var.ecr-policy-arn
  ])

  policy_arn = each.value
  role       = aws_iam_role.node-group-role.name
}
