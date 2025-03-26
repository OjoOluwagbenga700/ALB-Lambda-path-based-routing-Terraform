# load_balancer.tf
resource "aws_lb" "main" {
  name               = "lambda-path-routing-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [module.networking.public_subnets[0], module.networking.public_subnets[1]]
}

resource "aws_lb_target_group" "users_tg" {
  name        = "users-lambda-tg"
  target_type = "lambda"
}

resource "aws_lb_target_group" "products_tg" {
  name        = "products-lambda-tg"
  target_type = "lambda"
}

resource "aws_lb_target_group_attachment" "users_lambda_attachment" {
  target_group_arn = aws_lb_target_group.users_tg.arn
  target_id        = aws_lambda_function.users_lambda_function.arn
  depends_on       = [aws_lambda_function.users_lambda_function]

}

resource "aws_lb_target_group_attachment" "products_lambda_attachment" {
  target_group_arn = aws_lb_target_group.products_tg.arn
  target_id        = aws_lambda_function.products_lambda_function.arn
  depends_on       = [aws_lambda_function.products_lambda_function]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "Default Response from ALB"
    }
  }
}

resource "aws_lb_listener_rule" "users_path_rule" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.users_tg.arn
  }

  condition {
    path_pattern {
      values = ["/users*"]
    }
  }
}

resource "aws_lb_listener_rule" "products_path_rule" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.products_tg.arn
  }

  condition {
    path_pattern {
      values = ["/products*"]
    }
  }
}
