# Network

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_compute_instance.nat](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance) | resource |
| [yandex_dns_zone.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_zone) | resource |
| [yandex_vpc_network.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_route_table.nat](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_security_group.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_security_group) | resource |
| [yandex_vpc_subnet.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.public](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_compute_image.nat_instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The resources folder ID | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of resources labels | `map(any)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the network | `string` | n/a | yes |
| <a name="input_nat_allow_stopping_for_update"></a> [nat\_allow\_stopping\_for\_update](#input\_nat\_allow\_stopping\_for\_update) | Whether allow Terraform to stop NAT instances in order to update their properties | `bool` | `true` | no |
| <a name="input_nat_core_fraction"></a> [nat\_core\_fraction](#input\_nat\_core\_fraction) | Core fraction for NAT instances | `number` | `100` | no |
| <a name="input_nat_cores"></a> [nat\_cores](#input\_nat\_cores) | CPU core count for NAT instances | `number` | `2` | no |
| <a name="input_nat_create"></a> [nat\_create](#input\_nat\_create) | n/a | `bool` | `false` | no |
| <a name="input_nat_disk_size"></a> [nat\_disk\_size](#input\_nat\_disk\_size) | Disk size for NAT instances | `number` | `10` | no |
| <a name="input_nat_disk_type"></a> [nat\_disk\_type](#input\_nat\_disk\_type) | Disk type for NAT instances | `string` | `"network-hdd"` | no |
| <a name="input_nat_image_id"></a> [nat\_image\_id](#input\_nat\_image\_id) | Image ID for NAT instances. Default is 'nat-instance-ubuntu' family image id | `string` | `null` | no |
| <a name="input_nat_ip_addresses"></a> [nat\_ip\_addresses](#input\_nat\_ip\_addresses) | A list of public IP addresses for NAT instances | `list(string)` | `null` | no |
| <a name="input_nat_memory"></a> [nat\_memory](#input\_nat\_memory) | RAM size for NAT instances | `number` | `2` | no |
| <a name="input_nat_platform_id"></a> [nat\_platform\_id](#input\_nat\_platform\_id) | Platform id for NAT instances | `string` | `"standard-v3"` | no |
| <a name="input_nat_preemptible"></a> [nat\_preemptible](#input\_nat\_preemptible) | Whether NAT instances preemptible | `bool` | `false` | no |
| <a name="input_nat_serial_port_enable"></a> [nat\_serial\_port\_enable](#input\_nat\_serial\_port\_enable) | Whether enable serial port for NAT instances | `string` | `"1"` | no |
| <a name="input_nat_sg_ids"></a> [nat\_sg\_ids](#input\_nat\_sg\_ids) | A list of security group IDs for NAT instances | `list(string)` | `[]` | no |
| <a name="input_nat_ssh_key"></a> [nat\_ssh\_key](#input\_nat\_ssh\_key) | SSH key for NAT instances | `string` | `null` | no |
| <a name="input_nat_user_data"></a> [nat\_user\_data](#input\_nat\_user\_data) | NAT instances user data | `string` | `null` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets CIDRs | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets CIDRs | `list(string)` | n/a | yes |
| <a name="input_region_azs"></a> [region\_azs](#input\_region\_azs) | A list of availability zones | `list(string)` | <pre>[<br>  "ru-central1-a",<br>  "ru-central1-b",<br>  "ru-central1-c"<br>]</pre> | no |
| <a name="input_vpc_domain"></a> [vpc\_domain](#input\_vpc\_domain) | The DNS name of private zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_instance_ids"></a> [nat\_instance\_ids](#output\_nat\_instance\_ids) | A list of IDs of NAT instances |
| <a name="output_nat_vpc_route_table_ids"></a> [nat\_vpc\_route\_table\_ids](#output\_nat\_vpc\_route\_table\_ids) | A list of IDs of NAT route tables |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | A set of IDs and Zones of public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | A set of IDs and Zones of private subnets |
| <a name="output_vpc_default_sg_id"></a> [vpc\_default\_sg\_id](#output\_vpc\_default\_sg\_id) | ID of default vpc security group |
| <a name="output_vpc_dns_zone_id"></a> [vpc\_dns\_zone\_id](#output\_vpc\_dns\_zone\_id) | ID of vpc private DNS zone |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the vpc network |
| <a name="output_vpc_sg_id"></a> [vpc\_sg\_id](#output\_vpc\_sg\_id) | ID of private and public subnets vpc security group |
<!-- END_TF_DOCS -->
