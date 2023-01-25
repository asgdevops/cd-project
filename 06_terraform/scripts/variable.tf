# Project variables
variable "environment" {
  default = "Development"
  type = string
}

variable "owner" {
  default = "Antonio Salazar"
  type = string
}

variable "project" {
  default = "cd-project"
  type = string
}


# Access variables
variable "access-key" {
  description = "Access key to AWS console"
}

variable "secret-key" {
  description = "Secret key to AWS console"
}

variable "region" {
  default     = "us-east-1"
  description = "VPC default Region"
  type        = string
}

# Network Variables
variable "availability-zone-1" {
    default     = "us-east-1e"
    description = "Availability Zone 1"
    type        = string 
}


variable "vpc-cidr" {
    default     = "10.0.0.0/16"
    description = "VPC CIDR Block"
    type        = string 
}

variable "public-subnet-1-cidr" {
    default     = "10.0.0.0/25"
    description = "Public Subnet 1 CIDR Block"
    type        = string 
}

# Instance variables
variable "ami" {
  # default     = "ami-09e67e426f25ce0d7" # ubuntu-focal-20.04-amd64-server-20210430
  default     = "ami-052efd3df9dad4825" # jammy-22.04-amd64-server-20220609
  description = "AWS Ubuntu 22.04 Image"
  type        = string
}

variable "instance-type" {
  default     = "t2.micro"
  description = "AWS T2 Micro EC2 Instance"
  type        = string
}

# SSH variables
variable "ssh-location" {
    default     = "0.0.0.0/0"
    description = "IP Address Tha Can SSH Into the EC2 Instance"
    type        = string 
}

variable "key-pair" {
  default     = "kp-antonio"
  description = "ssh key pair name"
  type        = string
}

variable "pem-file" {
  default     = "kp-antonio.pem"
  description = "pem filename"
  type        = string
}

# EC2 user
variable "host-username" {
  default     = "ubuntu"
  description = "AWS EC2 host username"
  type        = string
}
