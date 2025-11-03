//////// Application Load Balancer

resource "aws_lb" "this" {
  name               = "${var.project}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]     #  from your SG module
  subnets            = var.public_subnet_ids

  tags = merge(var.tags, { Name = "${var.project}-${var.env}-alb" })
}


# Target Group for Backend (port 5000)

resource "aws_lb_target_group" "backend_tg" {
  name     = "${var.project}-${var.env}-tg"
  port     = 5000                           #  backend app port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"               # or "/health"
    protocol            = "HTTP"
    port                = "5000"            #  match backend port
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, { Name = "${var.project}-${var.env}-tg" })
}


#  Listener (HTTP :80 → backend :5000)

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}


# Attach Backend EC2 Instance to Target Group

resource "aws_lb_target_group_attachment" "backend_attach" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = var.backend_instance_id
  port             = 5000                   # match backend port
}
