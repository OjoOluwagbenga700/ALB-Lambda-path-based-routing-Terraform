variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {

  default = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "tf-vpc"
}
variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}
variable "public_subnets" {

  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
