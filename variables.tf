
# Variables File


variable "prefix" {
  description = "This prefix will be included in the name of most resources. Prod, Dev, QA"
}

variable "region" {
  description = "The region where the resources are created."
}

variable "AMI" {
  description = "The Packer Image for your WebApp."
  default = "ami-09399ab07dc45568b"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

variable "placeholder" {
  default     = "placedog.net/800/600?random"
  description = "Image-as-a-service URL."
}
