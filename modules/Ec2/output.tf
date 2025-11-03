# output "frontend_instance_id" {
# value = aws_instance.this.id
# }


# output "instance_public_ip" {
# value = aws_instance.this.public_ip
# }


# output "backend_private_ip" {
#   value = aws_instance.backend.private_ip
# }

# output "backend_id" {
#   value = aws_instance.backend.id
# }

output "instance_id" {
  value = aws_instance.this.id
}




output "backend_private_ip" {
  value = aws_instance.backend.private_ip
}


output "backend_id" {
  value = aws_instance.backend.id
}
