# --- 1. Get ALL Subnets (Ignore Public/Private flags) ---
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# --- 2. Get Details for AZ Grouping ---
data "aws_subnet" "details" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}

# --- 3. Smart Grouping: Force 1 Subnet per AZ ---
locals {
  # Group by AZ: { "us-east-2a" = ["subnet-1", "subnet-2"], "us-east-2b" = ["subnet-3"] }
  subnets_by_az = {
    for s in data.aws_subnet.details : s.availability_zone => s.id...
  }
  
  # Pick exactly ONE ID from each AZ
  # This results in: ["subnet-1", "subnet-3"] -> Perfect for ALB
  selected_subnets = [
    for az, ids in local.subnets_by_az : ids[0]
  ]
}

# --- 4. The ALB Resource ---
resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  
  # USE THE CALCULATED LIST
  subnets            = local.selected_subnets

  tags = { Name = "${var.project_name}-alb" }
}

# ... (Keep your Target Group, Listener, and Security Group resources below) ...
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