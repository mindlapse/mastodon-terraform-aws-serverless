
variable "vpc_cidr_prefix" {
  type        = string
  description = "the cidr for the VPC"
}

variable "num_azs" {
  type        = number
  default     = 2
  description = "The number of AZs"
}
