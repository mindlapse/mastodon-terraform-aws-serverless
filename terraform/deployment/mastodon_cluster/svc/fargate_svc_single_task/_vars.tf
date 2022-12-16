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


/* Config */

variable "simple_name" {
  type = string
}

variable "container_port" {
  type        = number
  default     = null
  description = "The port on which to deploy a container"
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "force_new_deployment" {
  type        = bool
  description = "Enable to force a new deployment"
}


/* Specs */

variable "cpu" {
  type        = number
  description = "Amount of CPU for cpu. 1024 = 1 vCPU"
}

variable "mem" {
  type        = number
  description = "Amount of memory for mem. 1024 = 1 GB"
}


/* Links */

variable "ecs_cluster_arn" {
  type        = string
  description = "the ARN of the ECS cluster where the service should be created"
}

variable "ecr_image_url" {
  type        = string
  description = "The URL of the aws_ecr_repository to deploy"
}

/* Routing */

variable "listener_arn" {
  type        = string
  default     = null
  description = "The ARN of the HTTPS listener, to which listener rules will be attached"
}

variable "path_pattern" {
  type        = string
  default     = null
  description = "The path pattern to needed for traffic to be routed. e.g. /api/v1/streaming"
}

variable "route_priority" {
  type        = number
  default     = 1
  description = "An integer priority for placing listener rules.  Rules eval from lowest to highest priority."
}



/* Runtime */
variable "working_directory" {
  type        = string
  description = "The base directory for the application"
}

variable "user" {
  type        = string
  description = "The linux name"
}

variable "health_check_command" {
  type        = list(string)
  description = "The check to ensure the container is healthy"
}

variable "run_command" {
  type        = list(string)
  description = "A check to ensure the container is runnable"
}

variable "environment" {
  type = list(object({
    name : string
    value : string
  }))
  default     = []
  description = "A list of environment variables to pass to the container"
}
