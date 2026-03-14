output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc_lite.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc_lite.public_subnet_id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = module.vpc_lite.internet_gateway_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.vpc_lite.public_route_table_id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.vpc_lite.security_group_id
}
