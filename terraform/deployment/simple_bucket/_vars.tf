variable "product" {
  type        = string
  description = "product codename, e.g. 'ta'"
}

variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "name" {
  type        = string
  description = "The portion of the bucket name after the product_env prefix"
}