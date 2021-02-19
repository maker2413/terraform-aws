# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.squids_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.squids_rds_subnetgroup.*.name
}

output "db_security_group" {
  value = [aws_security_group.squids_sg["rds"].id]
}
