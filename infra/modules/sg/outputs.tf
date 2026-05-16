output "rds-sg-id" {
  value = aws_security_group.rds-sg.id
}

output "node-sg-id" {
  value = aws_security_group.node-sg.id
}