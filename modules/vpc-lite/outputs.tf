output "vpc_id" {
  description = "Created VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Created public subnet ID"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "Created internet gateway ID"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "Created public route table ID"
  value       = aws_route_table.public.id
}

output "security_group_id" {
  description = "Created security group ID"
  value       = aws_security_group.public.id
}
