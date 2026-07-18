data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github-actions" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]

  tags = {
    Name = "github-actions-oidc"
  }
}

resource "aws_iam_role" "github-actions" {
  name                 = "github-actions-oidc-role"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github-actions.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:sudo-suadKF/KubeMemos-EKS:ref:refs/heads/main",
              "repo:sudo-suadKF/SentinelStack-Gatus:ref:refs/heads/main",
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecr" {
  name = "ecr-access-policy"
  role = aws_iam_role.github-actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
        Resource = [
          var.ecr-repo-arn,
          "arn:aws:ecr:eu-west-2:${data.aws_caller_identity.current.account_id}:repository/gatus-ecs-project",
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "terraform" {
  name = "terraform-permission-policy"
  role = aws_iam_role.github-actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "rds:*",
          "eks:*",
          "iam:*",
          "secretsmanager:*",
          "kms:*",
          "logs:*",
          "route53:*",
          "lambda:*",
          "acm:*",
          "elasticloadbalancing:*",
          "ecs:*",
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Resource = [
          "${var.s3-bucket-arn}/*",
          "arn:aws:s3:::terraform-state-gatus-ecs-project/*"
        ]
      },
      {
        Effect : "Allow"
        Action : ["s3:ListBucket"]
        Resource : [
          var.s3-bucket-arn,
          "arn:aws:s3:::terraform-state-gatus-ecs-project"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ]
        Resource = var.s3-kms-key-arn
      },
    ]
  })
}

resource "aws_iam_role_policy" "cicd-guardrails" {
  name = "cicd-guardrails"
  role = aws_iam_role.github-actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Action = [
          "iam:CreateUser",
          "iam:CreateAccessKey",
          "organizations:*",
          "account:*",
        ]
        Resource = "*"
      },
      {
        Effect = "Deny"
        Action = [
          "iam:UpdateAssumeRolePolicy",
        ]
        Resource = aws_iam_role.github-actions.arn
      }
    ]
  })
}
