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

variable "max_capacity" {
  type        = number
  default     = 10
  description = "Maximum capacity"
}

variable "cpu_threshold" {
  type        = number
  default     = 75
  description = "CPU threshold to initiate scale-out"
}