# --- loadbalancing/main.tf ---

resource "aws_lb" "squids_lb" {
  name            = "squids-lb"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout    = 400
}

resource "aws_lb_target_group" "squids_tg" {
  for_each = var.target_groups
  name     = "squids-lb-tg-${substr(uuid(), 0, 3)}"
  port     = each.value.port
  protocol = each.value.protocol
  vpc_id   = var.vpc_id
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold   = each.value.health_check.healthy_threshold
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
    timeout             = each.value.health_check.timeout
    interval            = each.value.health_check.interval
  }
}

resource "aws_lb_listener" "squids_lb_listener" {
  load_balancer_arn = aws_lb.squids_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.squids_tg["squids_tg"].arn
  }
}
