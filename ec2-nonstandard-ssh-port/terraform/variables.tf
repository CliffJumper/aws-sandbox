# Required Parameters
variable "ec2_key_name" {
  type = string
  description = "Name of the EC2 SSH Key pair to use"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the VPC to put the instance in"
}

# Optional Parameters
variable "allowed_cidr" {
  type        = string
  description = "CIDR to allow SSH from, using the SG ingress"
  default     = "0.0.0.0/0"
}

variable "instance_name" {
  type        = string
  description = "Name for the EC2 Instance"
  default     = "test-ec2-instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance type"
  default     = "t4g.nano"
}

variable "region" {
  type        = string
  description = "Region to deploy within"
  default     = "us-east-2"
}

variable "ssh_port" {
  type        = number
  description = "Port number to use for SSH"
  default     = 22
}