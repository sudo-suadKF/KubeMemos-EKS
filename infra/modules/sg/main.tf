resource "aws_security_group" "rds-sg" {
  name        = var.rds-sg-name
  description = var.rds-sg-description
  vpc_id      = var.vpc-id

  tags = {
    Name = var.rds-sg-tag
  }
}

resource "aws_security_group" "lambda-sg" {
  name        = var.lambda-sg-name
  description = var.lambda-sg-description
  vpc_id      = var.vpc-id

  tags = {
    Name = var.lambda-sg-tag
  }
}

resource "aws_security_group" "vpc-endpoints-sg" {
  name        = var.vpc-endpoints-sg-name
  description = var.vpc-endpoints-sg-description
  vpc_id      = var.vpc-id

  tags = {
    Name = var.vpc-endpoints-sg-tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds-sg-ingress" {
  description                  = "ingress rule for rds sg"
  security_group_id            = aws_security_group.rds-sg.id
  referenced_security_group_id = var.eks-cluster-sg-id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_vpc_security_group_ingress_rule" "rds-to-lambda" {
  description                  = "PostgreSQL from lambda"
  security_group_id            = aws_security_group.rds-sg.id
  referenced_security_group_id = aws_security_group.lambda-sg.id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "rds-sg-egress" {
  description       = "egress for rds sg"
  security_group_id = aws_security_group.rds-sg.id
  ip_protocol       = var.ip-protocol_-1
  cidr_ipv4         = var.internet-cidr
}

resource "aws_vpc_security_group_egress_rule" "lambda-to-rds" {
  description                  = "PostgresSQl to database"
  security_group_id            = aws_security_group.lambda-sg.id
  referenced_security_group_id = aws_security_group.rds-sg.id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "lambda-to-secrets-manager" {
  description                  = "HTTPS to Secrets Manager endpoint"
  security_group_id            = aws_security_group.lambda-sg.id
  referenced_security_group_id = aws_security_group.vpc-endpoints-sg.id
  ip_protocol                  = var.ip-protocol-tcp
  from_port                    = 443
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "endpoint-ingress" {
  description       = "HTTPS traffic from VPC"
  security_group_id = aws_security_group.vpc-endpoints-sg.id
  cidr_ipv4         = var.vpc-cidr
  ip_protocol       = var.ip-protocol-tcp
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "endpoint-egress" {
  description       = "VPC endpoints egress rule"
  security_group_id = aws_security_group.vpc-endpoints-sg.id
  cidr_ipv4         = var.internet-cidr
  ip_protocol       = var.ip-protocol_-1
}

#test for infracost
