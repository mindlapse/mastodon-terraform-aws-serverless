

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


/* Container URLs */

variable "ecr_puma_url" {
  type        = string
  description = "The URL of the aws_ecr_repository to use for Mastodon's Puma container"
}

/* Sizing */

variable "cpu_puma" {
  type        = string
  default     = 256
  description = "Amount of CPU for puma. 1024 = 1 vCPU"
}

variable "mem_puma" {
  type        = string
  default     = 512
  description = "Amount of memory for puma. 1024 = 1 GB"
}


/* Routing */

variable "puma_target_group_arn" {
  type        = string
  description = "The ARN of the target group for the puma task"
}


/* Ports */

variable "port_puma" {
  type        = number
  description = "The port for puma (i.e. the web container in mastodon)"
  default     = 3000
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