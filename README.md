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
`app_name` | application name |
`authorized_keys` | public keys for SSH access |
`az_count` | number of availability zones to span | 2
