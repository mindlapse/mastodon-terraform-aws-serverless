/* Common parameters */

variable "product" {
  type        = string
  description = "product codename, e.g. 'mast'"
}

variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "simple_name" {
  type        = string
  description = "A simple name to distinguish this autoscaling config from others"
}


/* Scaling target parameters */

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "service_name" {
  type        = string
  description = "The name of the ECS service"
}


/* Scale up params */

variable "scale_up_cron" {
  type = string
  description = "A cron statement for when to scale up. Example: cron(55 23 * * ? *)"
}


variable "scale_dn_cron" {
  type = string
  description = "A cron statement for when to scale up. Example: cron(55 23 * * ? *)"
}

variable "scale_up_min_instances" {
  type = number
  description = "The min number of instances during the scale up period"
}

variable "scale_dn_min_instances" {
  type = number
  description = "The min number of instances after the scale up period"
}

variable "max_instances" {
  type = number
  description = "The max number of instances during the scale up period"
}
