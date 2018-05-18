variable "unique_name" {
  default = "my_nginx_project"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "image_id" {
  default = "ami-4e79ed36"
}

variable "key_name" {
  default = "Test"
}

variable "region" {
  default = "us-west-2"
}

variable "subnet_ids" {
  default = ""
}

variable "min_nginx_servers" {
  default = "3"
}

variable "max_nginx_servers" {
  default = "3"
}

variable "desired_nginx_servers" {
  default = "3"
}

variable "vpc_cidr" {
  default = "10.50.0.0/16"
}

variable "private_subnets" {
  type = "list"
  default = ["10.50.1.0/24", "10.50.2.0/24", "10.50.3.0/24"]
}

variable "public_subnets" {
  type = "list"
  default = ["10.50.101.0/24", "10.50.102.0/24", "10.50.103.0/24"]
}


#variable "security_group_ids" {
#  default = ""
#}
