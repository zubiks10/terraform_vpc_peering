variable "region" {
  default = "us-east-1"
}

variable "dev_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "test_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "prod_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "prod_vpc_id" {
  default = "prod_vpc_id_here"
}
