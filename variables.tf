variable "unique_name" {
  default = "consumer_track"
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



#variable "security_group_ids" {
#  default = ""
#}
