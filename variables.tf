variable "prefix" {
  default = "norman"
}

variable "vpc_name" {
  description = "The VPC Name to use"
  type        = string
  default     = "norman-vpc-module2-assignment6"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/20"
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3
  }
}

variable "key_pair" {
  type        = string
  description = "Key pair name"
  default     = "norman-key-terraform"
}

variable "ami_instance_type_t2_micro" {
  type        = string
  description = "ami instance type t2.micro"
  default     = "t2.micro"
}
