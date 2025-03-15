variable "datadog_api_key" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "The AWS key pair for SSH access"
  type        = string
  sensitive   = true
}

variable "ec2_host_ip" {
  description = "The ID of the VPC"
  type        = string
  sensitive   = true
}

variable "url" {
  description = "The ID of the VPC"
  type        = string
  sensitive   = true
}

variable "slack_channel" {
  description = "The name of the channel in slack for sending alerts from Datadog"
  type        = string
  default     = "CamTech-alerts"
}

variable "monitor-tags" {
  description = "The common tags for monitors in Datadog"
  type        = string
  default     = "environment:demo, team:devops, service:python-stock-quote"
}