output "rds-sg-id" {
  value = aws_security_group.rds-sg.id
}

output "lambda-sg-id" {
  value = aws_security_group.lambda-sg.id
}

output "vpc-endpoints-sg-id" {
  value = aws_security_group.vpc-endpoints-sg.id
}