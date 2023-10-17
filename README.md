# AWS-EC2-Basic-Arc
Using Terraform to deploy a basic architecture for ec2 instances running apache services.

## Architecture
The principal idea is to Work with Terraform and AWS to build this diagram:
![AWS-ec2-basic-arc](https://github.com/tinchom/AWS-EC2-Basic-Arc/assets/7529358/d52fd483-abdc-4a6d-bcd8-ebfe3a1275ee)


### Deploy the Code & Infrastructure
The procedure to deploy the infrastructure and the code need the following code:
- Create an AWS account. One option to test is to use [free tier aws account](https://aws.amazon.com/free/).
- Install and configure [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Install and configure [Terraform](https://www.terraform.io/downloads.html)

Go to the environment, for this example i am using "AWS-EC2-Basic-ARC":

```bash
$ cd terraform/AWS-EC2-Basic-ARC
```
```bash
$ git clone 
```
- Initialised Terraform
```bash
$ terraform init
```
- Validate the configuration
```bash
$ terraform validate
```
- Execute the terraform plan (its going to ask you for key and secret)
```bash
$ terraform plan -out AWS-EC2-Basic-ARC.plan
```
- Apply the terraform plan
```bash
$ terraform apply "AWS-EC2-Basic-ARC"
```
If everything went right, you can view the architecture deployed on your account.

### Files descriptions

- `vpc.tf:` This file contain the creation of VPC, Subnet, Internet GW, NAT GW, Route tables, Subnet Associations and Elastic IPs resources.
- `sg.tf:` This file contain the creation of Security Groups resources required for EFS connection.
- `ec2.tf:` This file contain the creation of EC2 resources/instances.
- `vars.tf:` This file contains the variables and values of access keys, secret key, subnet settings and availabilty zones. For this case is set to us-east-1a and us-east-1b.

### Results
If all went well you will have 2 instances running in public and private subnets. The private will access to HTTP services running EC2 public instance.


