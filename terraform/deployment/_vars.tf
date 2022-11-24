variable "env" {
    type = string
    description = "[dev, prod]"
}

variable "product" {
    type = string
    description = "product codename, e.g. 'ta'"
}

variable "vpc_cidr" {
    type = string
    description = "the cidr for the VPC"
}