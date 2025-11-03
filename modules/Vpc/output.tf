# output "vpc_id" {
#   value = aws_vpc.this.id
# }

# output "public_subnet_ids" {
#   value = values(aws_subnet.public)[*].id
# }


# VPC ID output
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.this.id
}

# Public subnet IDs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for s in aws_subnet.public : s.id]
}

# Private subnet IDs (for backend, DBs, etc.)
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for s in aws_subnet.private : s.id]
}


output "igw_id" {
  value = aws_internet_gateway.igw
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}