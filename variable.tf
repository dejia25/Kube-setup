variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 3
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  default        = "ami-07ebfd5b3428b6f4d"
}

variable "region" {
  description = "Region to use"
  default        = "us-east-1"
}


variable "instance_type" {
  description = "Instance type to use"
  default        = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykeyss"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykeyss.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

