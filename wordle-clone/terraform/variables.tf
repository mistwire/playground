# variables.tf
variable "aws_region" {
  description = "AWS region to deploy to"
  default     = "us-west-2"
}

variable "subnet_ids" {
  description = "Subnet IDs for the ECS service"
  type        = list(string)
}

