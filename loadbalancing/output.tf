# --- loadbalancing/outputs.tf ---

output "lb_target_group_arn" {
  value = aws_lb_target_group.squids_tg["squids_tg"].arn
}

output "lb_endpoint" {
  value = aws_lb.squids_lb.dns_name
}
