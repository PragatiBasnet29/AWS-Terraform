provider "aws" {
  region = var.region
}

# EC2 Security Group - Allows inbound on port 80 from ALB SG only
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Allow HTTP inbound traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow HTTP from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [var.alb_sg_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-ec2-sg"
    Environment = var.environment
  }
}

# Launch Template for EC2 instances
resource "aws_launch_template" "ec2_lt" {
  name_prefix   = "${var.environment}-lt-"
  image_id      = data.aws_ami.amzn2.id
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
    subnet_id                  = element(var.public_subnet_ids, 0)
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.environment}-ec2-instance"
      Environment = var.environment
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.environment}-asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  vpc_zone_identifier       = var.public_subnet_ids
  launch_template {
    id      = aws_launch_template.ec2_lt.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  force_delete              = true
  tags = [
    {
      key                 = "Name"
      value               = "${var.environment}-asg-instance"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.environment
      propagate_at_launch = true
    }
  ]
}

data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

