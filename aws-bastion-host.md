# Steps to Set Up Bastion Host on AWS

This Bastion Host is set up so that one could connect to the Postgres RDS that is not exposed to the public internet. 

## Spin up an EC2 Instance
- Ubuntu (or any linux that has SSH)
- t2.micro is enough
- select VPC subnet (should be same as the RDS is)
- select storage (default is fine, more if one intents to use it to download anything)

## Create Security Groups
### public-to-bastion
- set inbound rules to only allow SSH from selected IP range

### bastion-to-rds
- set inbound rule to allow SSH from public-to-bastion security group
- set inbound rule to allow Postgresql conn on Port 5432 from public-to-bastion security group

## Add security groups to Bastion and RDS
- add public-to-bastion to bastion ec2
- add bastion-to-rds to RDS instance

### Elastic IP for Bastion
- get a static public IP for bastion

