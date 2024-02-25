variable "env_code" {
  type        = string
  description = "value"
  default     = "cloudheight-vpc"
}

variable "vpc_name" {
  type        = string
  description = "name of the vpc"
  default     = "infra-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = " vpc cidr block "
  default     = "10.6.0.0/16"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = " private subnet cidr block "
  default     = ["10.6.0.0/20", "10.6.16.0/20", "10.6.32.0/20"]
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = " public subnet cidr block "
  default     = ["10.6.48.0/20", "10.6.64.0/20", "10.6.80.0/20"]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
