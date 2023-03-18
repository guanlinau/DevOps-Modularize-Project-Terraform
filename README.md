### Modularize Project

### Technologies used:

Terraform, AWS, Docker, Linux, Git

### Project Description:

1-Divide Terraform resources into reusable modules

### Instruction:

1-Create subnet and webserver module under the modules folder and divide terraform resources into the two modules

2-Create a terraform.tfvars file under the root of the current folder with the following variables

```
vpc_cidr_block =
subnet_cidr_block =
availability_zone =
env_profix =
my_ip_address =
instance_type =
public_key_location  =
private_key_location =

aws_ami_image =
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
