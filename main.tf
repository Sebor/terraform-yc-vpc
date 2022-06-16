data "yandex_compute_image" "nat_instance" {
  family = "nat-instance-ubuntu"
}

resource "yandex_vpc_network" "this" {
  name = var.name

  labels = var.labels
}

resource "yandex_dns_zone" "this" {
  zone             = "${var.vpc_domain}."
  description      = "Local DNS zone for ${var.name} VPC"
  public           = false
  private_networks = [yandex_vpc_network.this.id]

  labels = var.labels
}

resource "yandex_vpc_subnet" "public" {
  count = length(var.public_subnets)

  name           = "${var.name}-pub-${var.public_subnets[count.index]}"
  zone           = var.region_azs[count.index]
  v4_cidr_blocks = [var.public_subnets[count.index]]
  network_id     = yandex_vpc_network.this.id

  dhcp_options {
    domain_name = var.vpc_domain
  }

  labels = var.labels
}

resource "yandex_vpc_subnet" "private" {
  count = length(var.private_subnets)

  name           = "${var.name}-pri-${var.private_subnets[count.index]}"
  zone           = var.region_azs[count.index]
  v4_cidr_blocks = [var.private_subnets[count.index]]
  network_id     = yandex_vpc_network.this.id

  dhcp_options {
    domain_name = var.vpc_domain
  }

  route_table_id = var.nat_create ? yandex_vpc_route_table.nat[count.index].id : null

  labels = var.labels
}


### SG configuration
resource "yandex_vpc_security_group" "this" {
  name        = var.name
  description = "VPC security group"
  network_id  = yandex_vpc_network.this.id

  ingress {
    protocol       = "ANY"
    description    = "VPC Subnets"
    v4_cidr_blocks = concat(var.private_subnets, var.public_subnets)
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "All"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  labels = var.labels
}

### NAT configuration
resource "yandex_vpc_route_table" "nat" {
  count = var.nat_create ? length(var.region_azs) : 0

  name       = "nat-${yandex_compute_instance.nat[count.index].zone}"
  network_id = yandex_vpc_network.this.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat[count.index].network_interface.0.ip_address
  }

  labels = var.labels
}

resource "yandex_compute_instance" "nat" {
  count = var.nat_create ? length(var.region_azs) : 0

  name        = "nat-${var.region_azs[count.index]}"
  hostname    = "nat-${var.region_azs[count.index]}"
  platform_id = var.nat_platform_id
  zone        = var.region_azs[count.index]

  allow_stopping_for_update = var.nat_allow_stopping_for_update

  resources {
    cores         = var.nat_cores
    memory        = var.nat_memory
    core_fraction = var.nat_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id != null ? var.nat_image_id : data.yandex_compute_image.nat_instance.id
      size     = var.nat_disk_size
      type     = var.nat_disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public[count.index].id
    nat                = true
    security_group_ids = flatten([yandex_vpc_security_group.this.id, var.nat_sg_ids])

    dns_record {
      fqdn        = "nat-${var.region_azs[count.index]}.${var.vpc_domain}."
      dns_zone_id = yandex_dns_zone.this.id
    }

    nat_ip_address = var.nat_ip_addresses != null ? var.nat_ip_addresses[count.index] : null
  }

  metadata = {
    user-data          = var.nat_user_data
    ssh-keys           = var.nat_ssh_key
    serial-port-enable = var.nat_serial_port_enable
  }

  scheduling_policy {
    preemptible = var.nat_preemptible
  }

  labels = var.labels
}
