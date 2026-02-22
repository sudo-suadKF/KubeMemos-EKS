output "public-subs-id" {
  value = [for key, subnet in aws_subnet.public_subnets : subnet.id]
}