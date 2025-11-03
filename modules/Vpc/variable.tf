variable "project" { 
    description = "name of the project"
    type = string 
    }

variable "env"     { 
    description = "enviroment workspace"
    type = string
     }
variable "cidr_block" {
     description = "cidr block range"
     type = string 
     }
variable "public_subnets" { 
    description = "subnet id"
    type = map(string)
     }
variable "tags" { type = map(string) }


variable "private_subnets" { 
    description = "subnet id"
    type = map(string)
     }
