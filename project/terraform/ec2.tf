
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


resource "aws_instance" "ansible" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.vm_size
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]

  tags = { Name = "ansible-node" }
}


resource "aws_instance" "app1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.vm_size
  subnet_id              = aws_subnet.private1.id
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  tags = { Name = "app-instance-1" }
}

resource "aws_instance" "app2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.vm_size
  subnet_id              = aws_subnet.private2.id
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  tags = { Name = "app-instance-2" }
}