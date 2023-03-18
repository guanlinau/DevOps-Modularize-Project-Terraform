### Automate AWS Infrastructure

### Technologies used:

Terraform, AWS, Docker, Linux, Git

### Project Description:

1-Create TF project to automate provisioning AWS Infrastructure and its components, such as: VPC, Subnet, Route Table, Internet Gateway, EC2, Security Group.

2-Configure TF script to automate deploying Docker container to EC2 instance

### Instruction:

1-Create a terraform.tfvars file under the root of the current folder with the following variables

```
vpc_cidr_block =
subnet_cidr_block =
availability_zone =
env_profix =
my_ip_address =
instance_type =
public_key_location  =
```

2-configure aws credentials with specified region and access_id and secret_key

```
aws configuration
```

3- Initialize the Terraform project

```
terraform init
```

4- Create the VPC and EC2 instance in it

```
terraform apply --auto-approve
```
