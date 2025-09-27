variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vm_size" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Key pair name for SSH"
  type        = string
  default     = "academy-key"
}
## toRename
variable "aws_access" {
  description = "aws access key"
  type        = string
}

variable "aws_secret" {
  description = "aws secret key"
  type        = string

}

variable "aws_token" {
  description = "aws session token"
  type        = string
}

