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