# Setting up an EC2 instance to listen for SSH connections on a port other than 22.

## Details

This will create an EC2 instance (t4g.nano, by default) and a security group setup to allow SSH on a port other than 22. The port is configurable via a variable.

### Assumptions
This assumes you already have a VPC with a public subnet setup (Tagged with "Tier = Public") to put the EC2 instance in. You can edit the logic in the `ec2.tf` file to change how a public subnet is selected.

### Usage
The default port is still set to 22.  To use a different port, change the setting of the `input_ssh_port` variable.

The Backend is not actually configured.  Edit the `providers.tf` file or pass the backend config on the `terraform` command line.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.11.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.instance_ssh_custom_port_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.instance_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.instance_ssh_custom_port_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_ami.al2023](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr"></a> [allowed\_cidr](#input\_allowed\_cidr) | CIDR to allow SSH from, using the SG ingress | `string` | `"0.0.0.0/0"` | no |
| <a name="input_ec2_key_name"></a> [ec2\_key\_name](#input\_ec2\_key\_name) | Name of the EC2 SSH Key pair to use | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name for the EC2 Instance | `string` | `"test-ec2-instance"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance type | `string` | `"t4g.nano"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy within | `string` | `"us-east-2"` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | Port number to use for SSH | `number` | `22` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of the VPC to put the instance in | `string` | n/a | yes |

## Outputs

No outputs.
