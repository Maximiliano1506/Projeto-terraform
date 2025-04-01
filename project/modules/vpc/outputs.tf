output "vpc_id" {
    value = aws_vpc.vpc.id
}
output "pub_subnets_id" {
    value = [for subnet in aws_subnet.pub_subnets : subnet.id]
}
output "priv_subnets_id" {
    value = [for subnet in aws_subnet.priv_subnets : subnet.id]
}