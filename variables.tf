variable "name" {
  type        = string
  description = "Name of the network"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets CIDRs"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets CIDRs"
}

variable "labels" {
  type        = map(any)
  default     = {}
  description = "A map of resources labels"
}

variable "vpc_domain" {
  type        = string
  description = "The DNS name of private zone"
}

variable "folder_id" {
  type        = string
  description = "The resources folder ID"
}

variable "region_azs" {
  type = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
  ]
  description = "A list of availability zones"
}

variable "nat_create" {
  type        = bool
  default     = false
  Description = "Whether create NAT instances"
}

variable "nat_preemptible" {
  type        = bool
  default     = false
  description = "Whether NAT instances preemptible"
}

variable "nat_image_id" {
  type        = string
  default     = null
  description = "Image ID for NAT instances. Default is 'nat-instance-ubuntu' family image id"
}

variable "nat_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Disk type for NAT instances"
}

variable "nat_disk_size" {
  type        = number
  default     = 10
  description = "Disk size for NAT instances"
}

variable "nat_cores" {
  type        = number
  default     = 2
  description = "CPU core count for NAT instances"
}

variable "nat_memory" {
  type        = number
  default     = 2
  description = "RAM size for NAT instances"
}

variable "nat_core_fraction" {
  type        = number
  default     = 100
  description = "Core fraction for NAT instances"
}

variable "nat_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform id for NAT instances"
}

variable "nat_ssh_key" {
  type        = string
  default     = null
  description = "SSH key for NAT instances"
}

variable "nat_sg_ids" {
  type        = list(string)
  default     = []
  description = "A list of security group IDs for NAT instances"
}

variable "nat_user_data" {
  type        = string
  default     = null
  description = "NAT instances user data"
}

variable "nat_ip_addresses" {
  type        = list(string)
  default     = null
  description = "A list of public IP addresses for NAT instances"
}

variable "nat_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "Whether allow Terraform to stop NAT instances in order to update their properties"
}

variable "nat_serial_port_enable" {
  type        = string
  default     = "1"
  description = "Whether enable serial port for NAT instances"
}
