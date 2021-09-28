
locals {
  cluster_name = var.cluster_resource.name
}

resource "aws_lb" "load_balancer" {
  name               = "${var.api_lb_name}-lb"
  internal           = false
  load_balancer_type = "application"

  // the subnets / AZs that this lb will operate in
  subnets = var.load_balancer_subnets
  // Must replace with a Terraform generated one
  security_groups = var.load_balancer_security_groups

  enable_deletion_protection = false

  //    access_logs {
  //      bucket  = aws_s3_bucket.lb_logs.bucket
  //      prefix  = "test-lb"
  //      enabled = true
  //    }

  tags = {
    Terraform = true
  }
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}

//data "aws_acm_certificate" "issued" {
//  domain   = "*.clairity-app.com"
//  statuses = ["ISSUED"]
//}

//resource "aws_lb_listener" "ssl_load_balancer_listener" {
//  load_balancer_arn = aws_lb.load_balancer.arn
//  port              = "443"
//  protocol          = "HTTPS"
//  certificate_arn = data.aws_acm_certificate.issued.arn
//  ssl_policy = "ELBSecurityPolicy-2016-08"
//
//  default_action {
//    type             = "forward"
//    target_group_arn = aws_alb_target_group.target_group.arn
//  }
//}

//resource "aws_lb_listener_certificate" "this" {
//  listener_arn    = aws_lb_listener.ssl_load_balancer_listener.arn
//  certificate_arn = data.aws_acm_certificate.issued.arn
//}

resource "aws_alb_target_group" "target_group" {
  name        = "${var.tg_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.target_group_vpc_id
  target_type = "ip"

  health_check {
    enabled  = true
    path     = "/health"
    interval = 60
    protocol = "HTTP"
  }

  tags = {
    Terraform = true
  }
}
