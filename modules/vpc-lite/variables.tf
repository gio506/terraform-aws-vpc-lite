variable "project_name" {
  description = "Name prefix used for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability Zone for the public subnet"
  type        = string
}

variable "ssh_ingress_cidrs" {
  description = "Allowed CIDR ranges for SSH"
  type        = list(string)
}

variable "http_ingress_cidrs" {
  description = "Allowed CIDR ranges for HTTP"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}
