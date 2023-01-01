

/* Common parameters */

variable "product" {
  type        = string
  description = "product codename, e.g. 'mast'"
}

variable "env" {
  type        = string
  description = "[dev, prod]"
}


/* Network */
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnets given to the cluster"
}


variable "listener_arn" {
  type        = string
  description = "The ARN of the HTTPS listener, to which listener rules will be attached"
}

variable "alb_domain" {
  type        = string
  description = "The hostname of the ALB"
}




/* Container Image URL */

variable "ecr_url" {
  type        = string
  description = "The URL of the aws_ecr_repository to use for Mastodon's Puma container"
}

/* Sizing */

variable "count_puma" {
  type        = number
  default     = 1
  description = "Number of puma instances desired"
}

variable "count_streaming" {
  type        = number
  default     = 1
  description = "Number of streaming instances desired"
}

variable "count_sidekiq" {
  type        = number
  default     = 1
  description = "Number of sidekiq instances desired"
}

/* Cluster */

variable "container_insights" {
  type        = string
  description = "Valid values: enable/disable. Toggles Container Insights for Amazon ECS"
  default     = "disabled"
}

variable "force_new_deployment" {
  type        = bool
  description = "Set to true enable force_new_deployment on services"
  default     = false
}