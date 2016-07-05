/*
 * network variables
 */

variable "app_name" {
  type = "string"
  description = "application name"
}

variable "environment" {
  type = "string"
  description = "environment to configure"
}

variable "region" {
  type = "string"
  description = "region to configure"
}

variable "cidr_base" {
  description = "first 2 octals of CIDR for each environment"
  default = {
    sandbox = "172.16"
    stage = "172.17"
    prod = "172.18"
  }
}

variable "cidr_public" {
  description = "last 2 octals of CIDR for public subnet"
  default = {
    "0" = "0.0"
    "1" = "1.0"
  }
}

variable "cidr_private" {
  description = "last 2 octals of CIDR for private subnet"
  default = {
    "0" = "128.0"
    "1" = "192.0"
  }
}

variable "cidr_private_bits" {
  description = "size of the CIDR mask for private subnets in each environment"
  default = {
    sandbox = 18
    stage = 18
    prod = 18
  }
}

variable "az_count" {
  description = "number of availability zones to span"
  default = 2
}

variable "az_list_region_offset" {
  description = "offset for az_list for a region"
  default = {
    us-west-2 = 0
    eu-central-1 = 4
  }
}

variable "az_list_environment_offset" {
  description = "offset for az_list for an environment"
  default = {
    sandbox = 0
    stage = 1
    prod = 2
  }
}

variable "az_list" {
  description = "availability zone list"
  default = {
    "0" = "us-west-2a"
    "1" = "us-west-2b"
    "2" = "us-west-2c"
    "3" = "us-west-2a"
    "4" = "eu-central-1a"
    "5" = "eu-central-1b"
    "6" = "eu-central-1a"
    "7" = "eu-central-1b"
  }
}

variable "cisco_cidr" {
  description = "IP block from Cisco"
  default = "128.107.0.0/16,173.36.0.0/16,72.163.0.0/16"
}

variable "bastion_image" {
  description = "AMI for bastion"
  default = {
    us-west-2 = "ami-f303fb93"
    eu-central-1 = "ami-7df01e12"
  }
}

variable "bastion_instance_type" {
  description = "instance type for bastion"
  default = "t2.micro"
}

variable "bastion_subnet_index" {
  description = "public subnet index (either 0 or 1)"
  default = 0
}

variable "jump_image" {
  description = "AMI for jump host"
  default = {
    us-west-2 = "ami-f303fb93"
    eu-central-1 = "ami-7df01e12"
  }
}

variable "jump_instance_type" {
  description = "instance type for jump host"
  default = "t2.micro"
}

variable "jump_subnet_index" {
  description = "private subnet index (either 0 or 1)"
  default = 0
}

variable "authorized_keys" {
  type = "string"
  description = "public keys for SSH access"
}

variable "name_delim" {
  description = "delimiter for the application name (used for one-offs)"
  default = "_"
}
