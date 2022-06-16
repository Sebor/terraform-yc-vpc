output "vpc_id" {
  value       = yandex_vpc_network.this.id
  description = "ID of the vpc network"
}

output "public_subnet_ids" {
  value = [
    for i in yandex_vpc_subnet.public : {
      zone      = i.zone
      subnet_id = i.id
    }
  ]
  description = "A set of IDs and Zones of private subnets"
}

output "private_subnet_ids" {
  value = [
    for i in yandex_vpc_subnet.private : {
      zone      = i.zone
      subnet_id = i.id
    }
  ]
  description = "A set of IDs and Zones of public subnets"
}

output "vpc_dns_zone_id" {
  value       = yandex_dns_zone.this.id
  description = "ID of vpc private DNS zone"
}

output "vpc_default_sg_id" {
  value       = yandex_vpc_network.this.default_security_group_id
  description = "ID of default vpc security group"
}

output "vpc_sg_id" {
  value       = yandex_vpc_security_group.this.id
  description = "ID of private and public subnets vpc security group"
}

output "nat_instance_ids" {
  value       = try(yandex_compute_instance.nat.*.id, [])
  description = "A list of IDs of NAT instances"
}

output "nat_vpc_route_table_ids" {
  value       = yandex_vpc_route_table.nat.*.id
  description = "A list of IDs of NAT route tables"
}
