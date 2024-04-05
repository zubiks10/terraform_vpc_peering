output "dev_subnet_id" {
  value = aws_subnet.dev_subnet.id
}

output "test_subnet_id" {
  value = aws_subnet.test_subnet.id
}

output "prod_subnet_id" {
  value = aws_subnet.prod_subnet.id
}

output "dev_to_prod_peering_id" {
  value = aws_vpc_peering_connection.dev_to_prod.id
}

output "test_to_prod_peering_id" {
  value = aws_vpc_peering_connection.test_to_prod.id
}
