variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "product" {
  type        = string
  description = "product codename, e.g. 'ta'"
}

variable "vpc_cidr_prefix" {
  type        = string
  description = "the cidr for the VPC"
}

variable "container_insights" {
  type        = string
  description = "Valid values: enable/disable. Toggles Container Insights for Amazon ECS"
  default     = "disabled"
}
