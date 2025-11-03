variable "ami" { 
    description = "ami of the instance"
    type = string 
    }

variable "instance_type" { 
    description = "ec2 instance type"
    type = string 
    default = "t3.micro" 
    }

variable "public_subnet_ids" {
     description = "name of the subnet id"
     type = list(string) 
     }

variable "key_name" {
     description = "aws key pair name"
     type = string
     }

variable "public_key" { 
        description = "path of the public key"
        type = string 
        }

variable "project" { 
    description = "name of the project"
    type = string 
    }

variable "env" { type = string }
# variable "root_volume_size" { type = number, default = 8 }
# variable "root_volume_type" { type = string, default = "gp3" }

variable "tags" {
    description = "name of the  ec2 "
     type = map(string)
     default = {} 
     }


variable "vpc_id" {
    description = "id of the vpc"
    type = string
  
}

variable"private_subnet_ids"{
    description = "private subnet id"
    type= list(string)
}

variable "frontend_sg" {
  description = "Security group ID for frontend EC2 instance"
  type        = string
}

variable "backend_sg" {
  description = "Security group ID for backend EC2 instance"
  type        = string
}
