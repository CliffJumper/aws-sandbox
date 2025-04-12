# Find latest ARM Amaazon Linux 2023 AMI
data "aws_ami" "al2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*.*.0-kernel-*-arm64"]
  }

  owners = ["amazon"]
}

# This all depends on the public subnets having tags named 'Tier' with value of 'Public'
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Tier = "Public"
  }
}

# Create a security group for the instance
resource "aws_security_group" "instance_ssh_custom_port_sg" {
  name        = "instance_ssh_custom_port_sg"
  description = "Security Group allowing SSH on a non-standard port (not port 22)"
  vpc_id      = var.vpc_id
  tags = {
    Name = "instance_ssh_custom_port_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "instance_ssh_custom_port_ingress" {
  security_group_id = aws_security_group.instance_ssh_custom_port_sg.id

  cidr_ipv4   = var.allowed_cidr
  from_port   = var.ssh_port
  ip_protocol = "tcp"
  to_port     = var.ssh_port
}

resource "aws_vpc_security_group_egress_rule" "instance_egress" {
  security_group_id = aws_security_group.instance_ssh_custom_port_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


# Setup Instance, and use user_data to setup SSH on the correct port
resource "aws_instance" "bastion" {
  instance_type               = var.instance_type
  ami                         = data.aws_ami.al2023.id
  subnet_id                   = element(data.aws_subnets.public.ids, 0)
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.instance_ssh_custom_port_sg.id]
  user_data                   = templatefile("${path.module}/user_data.tmpl", { SSH_PORT = var.ssh_port })
  key_name                    = var.ec2_key_name

  tags = {
    Name = var.instance_name
  }

}
