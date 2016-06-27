# Network Module

## Description

This module creates the following:
1. VPC;
2. internet gateway;
3. subnets (public and private);
4. NAT gateway (for each private subnet);
5. security groups;
6. bastion hosts (one for each public subnet); and
7. jump hosts (one for each private subnet).

This module creates 2 subnets for HA.

## Variables

Name | Description | Default
---- | ----------- | -------
`app_name` | application name | |
`authorized_keys` | public keys for SSH access | |
`bastion_image` | AMI for bastion instance | standard Amazon Linux image
`bastion_instance_type` | instance type for bastion instance | t2.micro
`environment` | environment to configure | |
`jump_image` | AMI for jump host | standard Amazon Linux image
`jump_instance_type` | instance type for jump host | t2.micro
`region` | region to configure | |

## Outputs

Name | Description
---- | -----------
`internal_security_group_id` | security group ID for instances in the private subnet
`nat_ips` | IP addresses for NAT gateways (comma separated list)
`private_subnet_ids` | IDs for the private subnets
`public_subnet_ids` | IDs for the public subnets
`public_web_security_group_id` | security group ID for instances in the public subnet
