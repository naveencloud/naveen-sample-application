# Below are the list of variable

variable "region" {
  description = "AWS region"
  default = "ap-south-1"
}

variable "application" {
  description = "application name"
  default = "application"
}

variable "environment" {
  description = "Environment to deploy"
  default = "dev"
}

variable "ami_id" {
  description = "AMI ID to create Instance"
  default = "ami-0e502bbbe5de26d28"
}

variable "instance_type" {
  description = "Instance type to create EC2 instance"
  default = "t2.medium"
}

variable "EC2_KEYPAIR_NAME" {
  description = "EC2 key pair Name"
}

