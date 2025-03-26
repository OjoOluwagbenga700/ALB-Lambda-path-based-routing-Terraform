data "archive_file" "users_lambda_zip" {
  type        = "zip"
  source_dir  = "src"
  output_path = "users_lambda.zip"
}

data "archive_file" "products_lambda_zip" {
  type        = "zip"
  source_dir  = "src"
  output_path = "products_lambda.zip"
}


# Create the Lambda Function
resource "aws_lambda_function" "users_lambda_function" {
  filename      = "users_lambda.zip"
  function_name = "lambdaFunction-users"
  runtime       = "python3.9"
  handler       = "users.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role, data.archive_file.users_lambda_zip]
  tags = {
    Name = "lambdaFunction-users"
  }
}

# Create the Lambda Function
resource "aws_lambda_function" "products_lambda_function" {
  filename      = "products_lambda.zip"
  function_name = "lambdaFunction-products"
  runtime       = "python3.9"
  handler       = "products.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role, data.archive_file.products_lambda_zip]
  tags = {
    Name = "lambdaFunction-products"
  }
}

# Allow the application load balancer to access Lambda Function
resource "aws_lambda_permission" "with_lb_users_function" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_lambda_function.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.users_tg.arn
}

# Allow the application load balancer to access Lambda Function
resource "aws_lambda_permission" "with_lb_products_function" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.products_lambda_function.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.products_tg.arn
}