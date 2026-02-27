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
