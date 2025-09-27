resource "aws_elb" "app_elb" {
  name               = "project2-elb"
  subnets            = [aws_subnet.public.id]     
  security_groups    = [aws_security_group.elb_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances = [
    aws_instance.app1.id,
    aws_instance.app2.id,
  ]

  tags = { Name = "project2-classic-elb" }
}
