variable "project" {}
variable "env" {}
variable "vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "backend_instance_id" {
  description = "ID of backend EC2 instance to attach"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
