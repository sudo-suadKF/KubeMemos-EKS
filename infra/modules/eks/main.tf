resource "aws_eks_cluster" "my-eks-cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.my-cluster-iam-role.arn
  version  = "1.35"

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids              = var.public-subs-id
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.policy-role-attach,
  ]
}

resource "aws_eks_addon" "my-addons" {
  count = length(var.addons)

  cluster_name = aws_eks_cluster.my-eks-cluster.name
  addon_name   = var.addons[count.index]

}

resource "aws_iam_role" "my-cluster-iam-role" {
  name = "eks-cluster-iam-role"
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
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.my-cluster-iam-role.name
}

resource "aws_eks_node_group" "my-node-group" {
  cluster_name = aws_eks_cluster.my-eks-cluster.name
  node_group_name = "my-node-group"
  node_role_arn = aws_iam_role.node-group-role.arn
  subnet_ids = var.private-subs-id

  scaling_config {
    desired_size = 3
    max_size = 4
    min_size = 1
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_iam_role" "node-group-role" {
  name = "eks-node-group-role"
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

resource "aws_iam_role_policy_attachment" "worker-node-ec2-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "networking-pod-ip-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "worker-node-ecr-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-role.name
}