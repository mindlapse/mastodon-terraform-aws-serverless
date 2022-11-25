variable "product" {
  type        = string
  description = "product codename, e.g. 'ta'"
}

variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnets to deploy the ALB to (one per AZ)"
}

variable "alb_security_group_id" {
  type        = string
  description = "The ID of the security group surrounding the ALB"
}

variable "access_logs" {
  type        = bool
  default     = false
  description = "Set to true to enable access logs"
}