variable "host-db" {
    description = "RDS DB host"
    type = string
}

variable "private-subs-id" {
    description = "Private subnets IDs"
    type = list(string)
}