resource "aws_security_group" "node-sg" {
  name        = "node-sg"
  description = "sg for eks worker nodes"
  vpc_id      = var.vpc-id

  tags = {
    Name = "eks-node-sg"
  }
}

# Nodes accepting traffic from cluster, port 443

resource "aws_vpc_security_group_ingress_rule" "cluster-to-node-HTTPS" {
  description                  = "ingress for cluster api to worker node"
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = var.eks-cluster-sg-id
  ip_protocol                  = "tcp"
  from_port                    = 443
  to_port                      = 443
}

# Kubelet accepting trafic from cluster, port 10250

resource "aws_vpc_security_group_ingress_rule" "cluster-to-kubelet" {
  description                  = "ingress for cluster api to kubelet"
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = var.eks-cluster-sg-id
  ip_protocol                  = "tcp"
  from_port                    = 10250
  to_port                      = 10250
}

# Node-to-node trafic, TCP + UDP

resource "aws_vpc_security_group_ingress_rule" "node-to-node-TCP" {
  description                  = "ingress for node to node TCP communication"
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = aws_security_group.node-sg.id
  ip_protocol                  = "tcp"
  from_port                    = 53
  to_port                      = 53
}

resource "aws_vpc_security_group_ingress_rule" "node-to-node-UDP" {
  description                  = "ingress for node to node UDP communication"
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = aws_security_group.node-sg.id
  ip_protocol                  = "udp"
  from_port                    = 53
  to_port                      = 53
}

# Node egress all

resource "aws_vpc_security_group_egress_rule" "node-egress" {
  description       = "egress for worker node to internet"
  security_group_id = aws_security_group.node-sg.id
  cidr_ipv4         = var.internet-cidr
  ip_protocol       = "-1"
}
