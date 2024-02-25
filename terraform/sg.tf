resource "aws_security_group" "private" {
  name        = "${var.env_code}-private"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.cloudheight-vpc.id

  ingress {
    description     = "Http from load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balanacer-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-my-sg"
  }
}

resource "aws_security_group" "load_balanacer-sg" {
  name        = "${var.env_code}-load-balancer"
  description = "Allow HTTP to the load balanacer"
  vpc_id      = aws_vpc.cloudheight-vpc.id

  ingress {
    description = "TCP FROM ANYWHERE"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-loadbalancer-my-sg"
  }
}
