resource "aws_eks_cluster" "my-eks-cluster" {
  name     = "my-eks-cluster"
  role_arn = ""
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


}

resource "aws_eks_addon" "my-addons" {
  count = length(var.addons)

  cluster_name = aws_eks_cluster.my-eks-cluster.name
  addon_name   = var.addons[count.index]

}
