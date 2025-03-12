variable "aws_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "The AWS key pair for SSH access"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

