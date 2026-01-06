variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone to place subnets in"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for tagging/name"
  default     = "tf-task2"
}
