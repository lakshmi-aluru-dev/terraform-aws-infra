variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for the instance (e.g., Ubuntu 22.04 AMI in your region)"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "Your public IP in CIDR format 44.192.12.45/32"
}

