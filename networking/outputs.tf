# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.squids_vpc.id
}
