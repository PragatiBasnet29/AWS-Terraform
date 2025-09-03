output "vpc_id" {
  value = aws_vpc.this.id
}

output "cidr_block" {
  value = var.cidr_block
}

output "main_route_table_id" {
  value = aws_route_table.public_rt.id
}
