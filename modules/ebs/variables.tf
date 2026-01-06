variable "availability_zone" {
  type        = string
  description = "AZ where the EBS volume will be created (must match the EC2 AZ)"
}

variable "size" {
  type        = number
  description = "EBS volume size in GB"
  default     = 10
}

variable "type" {
  type        = string
  description = "EBS volume type"
  default     = "gp3"
}

variable "encrypted" {
  type        = bool
  description = "Whether the EBS volume is encrypted"
  default     = true
}

variable "name" {
  type        = string
  description = "Name tag for the EBS volume"
  default     = "task4-data-ebs"
}

variable "instance_id" {
  type        = string
  description = "EC2 instance ID to attach the volume to"
}

variable "device_name" {
  type        = string
  description = "Device name for attachment (e.g., /dev/sdf)"
  default     = "/dev/sdf"
}
