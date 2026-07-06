output "rds-sg-id" {
  value = aws_security_group.rds-sg.id
}

output "lambda-sg.id" {
  value = aws_security_group.lambda-sg.id
}