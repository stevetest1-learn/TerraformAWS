variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Value of the CIDR range for the VPC"
}

variable "vpc_name" {
  type        = string
  default     = "MyTestVPC"
  description = "Value of the Name of the VPC"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Value of the subnet range for the VPC"
}

variable "subnet_name" {
  type        = string
  default     = "1MyTestSubnet"
  description = "Value of the subnet range"
}
variable "igw_name" {
  type        = string
  default     = "MyTestIGW"
  description = "Value of the Inernet Gateway"
}
variable "ec2_ami" {
  type        = string
  default     = "ami-02dfbd4ff395f2a1b"
  description = "Value of the EC2 Instance"
}
variable "ec2_name" {
  type        = string
  default     = "MyTestEC2"
  description = "Value of name the EC2 Instance"
}