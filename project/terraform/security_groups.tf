# -------------------------
# Security Group for App EC2 Instances
# -------------------------
resource "aws_security_group" "app_sg" {
  name        = "App-SG"
  description = "Security Group for App EC2"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "App-SG"
  }
}

# Allow HTTP/HTTPS traffic from ELB
resource "aws_security_group_rule" "app_allow_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "app_allow_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.elb_sg.id
}

# Outbound traffic allowed
resource "aws_security_group_rule" "app_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}


# -------------------------
# Security Group for Ansible Node
# -------------------------
resource "aws_security_group" "ansible_sg" {
  name        = "Ansible-SG"
  description = "Security Group for Ansible Node in Public Subnet"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Ansible-SG"
  }
}

# Allow SSH from the internet
resource "aws_security_group_rule" "ansible_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ansible_sg.id
}

# Outbound traffic allowed
resource "aws_security_group_rule" "ansible_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ansible_sg.id
}


# -------------------------
# Security Group for ELB
# -------------------------
resource "aws_security_group" "elb_sg" {
  name        = "ELB-SG"
  description = "Security Group for Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ELB-SG"
  }
}

# Allow HTTP/HTTPS from the internet
resource "aws_security_group_rule" "elb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_sg.id
}

resource "aws_security_group_rule" "elb_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_sg.id
}

# Outbound traffic allowed
resource "aws_security_group_rule" "elb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_sg.id
}
