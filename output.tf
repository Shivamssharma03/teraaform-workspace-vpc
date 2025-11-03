output "vpc_id" {
value = module.vpc.vpc_id
}


output "frontend_instance_id" {
value = module.ec2.instance_id
}



# output "backend_instance_id" {
# value = module.ec2.instance_id
# }
output "assets_bucket" {
value = module.s3.bucket_id
}