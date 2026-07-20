data "aws_secretsmanager_secret" "rds-credentials" {
  name = var.secret-name
}

data "aws_kms_key" "by_alias" {
  key_id = var.secret-alias
}

data "aws_route53_zone" "my-hosted-zone" {
  name         = var.my-hosted-zone-name
  private_zone = false
}

resource "aws_iam_role" "pod-id-external-dns" {
  name = var.iam-role-pod-id-dns-name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid : "AllowEksAuthToAssumeRoleForPodIdentity"
      Effect = "Allow"
      Principal = {
        Service = "pods.eks.amazonaws.com"
      }
      Action = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }]
  })

  tags = {
    Name = var.iam-role-pod-id-dns-tags
  }
}

resource "aws_iam_policy" "external-dns" {
  name = var.external-dns

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ChangeResourceRecordSets"
        ]
        Resource = [
          "arn:aws:route53:::hostedzone/${data.aws_route53_zone.my-hosted-zone.zone_id}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource"
        ]
        Resource = ["*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-pod-id-dns" {
  policy_arn = aws_iam_policy.external-dns.arn
  role       = aws_iam_role.pod-id-external-dns.name
}

resource "aws_eks_pod_identity_association" "external-dns" {
  cluster_name    = var.eks-cluster-name
  namespace       = var.external-dns
  service_account = var.external-dns
  role_arn        = aws_iam_role.pod-id-external-dns.arn
}

resource "aws_iam_role" "pod-id-external-secrets" {
  name = var.external-secret-pod-id-name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid : "AllowEksAuthToAssumeRoleForPodIdentity"
      Effect = "Allow"
      Principal = {
        Service = "pods.eks.amazonaws.com"
      }
      Action = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }]
  })

  tags = {
    Name = var.external-secret-pod-id-tag
  }
}

resource "aws_iam_policy" "external-secrets" {
  name = var.external-secret-policy-name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ]
      Resource = data.aws_secretsmanager_secret.rds-credentials.arn
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ]
        Resource = data.aws_kms_key.by_alias.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-pod-id-secrets" {
  policy_arn = aws_iam_policy.external-secrets.arn
  role       = aws_iam_role.pod-id-external-secrets.name
}

resource "aws_eks_pod_identity_association" "external-secrets" {
  cluster_name    = var.eks-cluster-name
  namespace       = var.external-secrets
  service_account = var.external-secrets
  role_arn        = aws_iam_role.pod-id-external-secrets.arn
}
