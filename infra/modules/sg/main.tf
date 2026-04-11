resource "aws_security_group" "node-sg" {
  name        = var.node-sg-name
  description = var.node-sg-description
  vpc_id      = var.vpc-id

  tags = {
    Name = var.node-sg-tags
  }
}

# Nodes accepting traffic from cluster, port 443

resource "aws_vpc_security_group_ingress_rule" "cluster-to-node-HTTPS" {
  description                  = var.ingress-rule-cluster-node-description
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = var.eks-cluster-sg-id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = var.port-HTTPS
  to_port                      = var.port-HTTPS
}

# Kubelet accepting trafic from cluster, port 10250

resource "aws_vpc_security_group_ingress_rule" "cluster-to-kubelet" {
  description                  = var.ingress-rule-cluster-kubelet-description
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = var.eks-cluster-sg-id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = var.port-10250
  to_port                      = var.port-10250
}

# Node-to-node trafic, TCP + UDP

resource "aws_vpc_security_group_ingress_rule" "node-to-node-TCP" {
  description                  = var.ingress-rule-node-node-TCP-description
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = aws_security_group.node-sg.id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = var.port-DNS
  to_port                      = var.port-DNS
}

resource "aws_vpc_security_group_ingress_rule" "node-to-node-UDP" {
  description                  = var.ingress-rule-node-node-UDP-description
  security_group_id            = aws_security_group.node-sg.id
  referenced_security_group_id = aws_security_group.node-sg.id
  ip_protocol                  = var.ip-protocol-udp
  from_port                    = var.port-DNS
  to_port                      = var.port-DNS
}

# Node egress all

resource "aws_vpc_security_group_egress_rule" "node-egress" {
  description       = var.egress-rule-node-description
  security_group_id = aws_security_group.node-sg.id
  cidr_ipv4         = var.internet-cidr
  ip_protocol       = var.ip-protocol_-1
}

# SG for RDS Proxy

# resource "aws_security_group" "rds-proxy-sg" {
#   name        = "rds-proxy-sg"
#   description = "sg for rds proxy"
#   vpc_id      = var.vpc-id

#   tags = {
#     Name = "rds-proxy-sg"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "rds-proxy-sg-ingress" {
#   description                  = "ingress rule for rds proxy sg"
#   security_group_id            = aws_security_group.rds-proxy-sg.id
#   referenced_security_group_id = aws_security_group.node-sg.id
#   ip_protocol                  = var.ip-protocol-tcp
#   from_port                    = 5432
#   to_port                      = 5432
# }

# resource "aws_vpc_security_group_egress_rule" "rds-proxy-sg-egress" {
#   description       = "egress rule for rds proxy sg"
#   security_group_id = aws_security_group.rds-proxy-sg
#   ip_protocol       = var.ip-protocol_-1
#   cidr_ipv4         = var.internet-cidr
# }

# SG for RDS db instance

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "sg for rds db instance"
  vpc_id      = var.vpc-id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds-sg-ingress" {
  description                  = "ingress rule for rds sg"
  security_group_id            = aws_security_group.rds-sg
  referenced_security_group_id = aws_security_group.node-sg
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "rds-sg-egress" {
  description       = "egress for rds sg"
  security_group_id = aws_security_group.rds-sg
  ip_protocol       = var.ip-protocol_-1
  cidr_ipv4         = var.internet-cidr
}
