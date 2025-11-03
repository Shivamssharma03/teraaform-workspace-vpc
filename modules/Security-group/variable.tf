variable "project" {
    description = "name of the project"
    type = string
  
}

variable "env" {
    description = "envirment workspace"
    type = string
  
}
variable "tags" { type = map(string) }

variable "vpc_id" {
    description = "vpc_id"
    type = string
}