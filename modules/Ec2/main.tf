resource "aws_key_pair" "this" {
key_name = var.key_name
public_key = file(var.public_key)
}

# resource "aws_security_group" "allow_ssh" {
#  name        = "${var.project}-${var.env}-allow-ssh"   # ✅ unique per env
#  description = "Allow SSH inbound traffic"
#  vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Open to all (you can restrict this to your IP)
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_instance" "this" {
ami = var.ami
instance_type = var.instance_type
subnet_id   = element(var.public_subnet_ids, 0)
key_name = aws_key_pair.this.key_name
vpc_security_group_ids = [var.frontend_sg]



tags = merge(var.tags, {
Name = "${var.project}-${var.env}-app"
})


# root_block_device {
# volume_size = var.root_volume_size
# volume_type = var.root_volume_type
# }
}
resource "aws_instance" "backend" {
  ami                   = var.ami
  instance_type         = var.instance_type
  subnet_id             = element(var.private_subnet_ids, 0)
  vpc_security_group_ids = [var.backend_sg]
  key_name              = aws_key_pair.this.key_name
   associate_public_ip_address = false

  tags = merge(var.tags, {
    Name = "${var.project}-${var.env}-backend"
  })
}

