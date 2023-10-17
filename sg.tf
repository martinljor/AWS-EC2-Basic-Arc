data "aws_vpc" "vpc_selected" {
  id = aws_vpc.main.id
}

resource "aws_security_group" "public_sg" {
  name   = "public-sg"
  vpc_id = aws_vpc.main.id

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group_rule" "ec2_sg_inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.vpc_selected.cidr_block]
  security_group_id = aws_security_group.public_sg.id
  description       = "VPC CIDR Inbound Access"
}

resource "aws_security_group_rule" "ec2_sg_inbound_http_any" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
  description       = "AWS-EC2-Basic-Architecture Public"
}