# --- 1. Find Public Subnets (Now works!) ---
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"] # This will now find your 2 public subnets
  }
}

# --- 2. Find Private Subnets ---
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["false"] # This will find your 2 private subnets
  }
}

# --- 3. Get Details to Group Public Subnets by AZ ---
data "aws_subnet" "public_details" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

locals {
  # Group Public subnets by AZ: { "us-east-1a" = ["subnet-X"], "us-east-1b" = ["subnet-Y"] }
  public_by_az = {
    for s in data.aws_subnet.public_details : s.availability_zone => s.id...
  }

  # Pick ONE Public subnet per AZ for the ALB
  alb_subnets = [
    for az, ids in local.public_by_az : ids[0]
  ]
}

# --- 4. The ALB Resource ---
resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  
  # Correctly uses only the Public subnets
  subnets            = local.alb_subnets

  tags = { Name = "${var.project_name}-alb" }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/"
    healthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.lb_port
    to_port     = var.lb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}