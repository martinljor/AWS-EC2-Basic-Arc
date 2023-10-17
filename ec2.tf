resource "aws_instance" "public_server" {
  ami           = "ami-041feb57c611358bd"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
   subnet_id   = aws_subnet.public_subnets[0].id
 user_data = <<EOF
#!/bin/bash
yum update -y 
yum install -y httpd php8.1 
systemctl enable httpd.service 
systemctl start httpd 
cd /var/www/html 
touch index.html
echo "Hello from public server!" >> index.html
EOF
  tags = {
    Name = "AWS-EC2-Basic-Architecture Public Server"
  }
}

resource "aws_instance" "private_server" {
  ami           = "ami-041feb57c611358bd"
  instance_type = "t2.micro"
 subnet_id   =  aws_subnet.private_subnets[0].id
 associate_public_ip_address = "false"
  tags = {
    Name = "AWS-EC2-Basic-Architecture Private Server"
  }
}