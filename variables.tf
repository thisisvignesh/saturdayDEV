variable "sgname" {
  description = "This name is for Security group"
  default     = "prodsg"
}

variable "cidr" {
  description = "vpc_cidr"
  default     = ["0.0.0.0/0"]
}



variable "subnets_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24"]
}
