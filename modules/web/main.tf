resource "aws_security_group" "web_server_sg" {
  name        = "${var.environment}-web-server-sg"
  description = "Security group for web that allows web traffic from internet"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-web-server-sg"
    Environment = "${var.environment}"
    App         = "${var.app_name}"
  }
}

resource "aws_security_group" "web_inbound_sg" {
  name        = "${var.environment}-web-inbound-sg"
  description = "Allow HTTP from Anywhere"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Environment = "${var.environment}"
    App         = "${var.app_name}"
  }
}

resource "aws_instance" "web" {
  count                  = "${var.web_instance_count}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.private_subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.web_server_sg.id}"]
  key_name               = "${var.key_name}"
  user_data              = "${file("${path.module}/files/user_data.sh")}"

  tags {
    Name        = "${var.environment}-web-${count.index + 1}"
    Environment = "${var.environment}"
    App         = "${var.app_name}"
  }
}

resource "aws_alb" "web" {
  name            = "${var.environment}-web-alb"
  subnets         = ["${var.public_subnet_id}", "${var.public_subnet_id_2}"]
  security_groups = ["${aws_security_group.web_inbound_sg.id}"]
  internal        = false

  tags {
    Environment = "${var.environment}"
    App         = "${var.app_name}"
  }
}

resource "aws_alb_target_group" "web-alb-tg" {
  name     = "${var.environment}-web-alb-tg"
  vpc_id   = "${var.vpc_id}"
  port     = "80"
  protocol = "HTTP"

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 5
    timeout             = 4
  }

  tags {
    Environment = "${var.environment}"
    App         = "${var.app_name}"
  }
}

resource "aws_alb_listener" "web-listener" {
  load_balancer_arn = "${aws_alb.web.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.web-alb-tg.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "web-alb-attachments" {
  target_group_arn = "${aws_alb_target_group.web-alb-tg.arn}"
  target_id        = "${element(aws_instance.web.*.id, count.index)}"
  port             = 80
}
