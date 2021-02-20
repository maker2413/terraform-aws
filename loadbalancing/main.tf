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
  health_check {
    healthy_threshold   = each.value.health_check.healthy_threshold
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
    timeout             = each.value.health_check.timeout
    interval            = each.value.health_check.interval
  }
}
