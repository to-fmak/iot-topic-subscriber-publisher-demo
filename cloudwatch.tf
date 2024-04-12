resource "aws_cloudwatch_log_group" "subscriber_lambda_lgp" {
  name              = "/aws/lambda/${var.lambda_function.subscriber.function_name}"
  retention_in_days = var.cloudwatch_log_group.subscriber_lambda_lgp_retention_in_days
}

resource "aws_cloudwatch_log_group" "publisher_lambda_lgp" {
  name              = "/aws/lambda/${var.lambda_function.publisher.function_name}"
  retention_in_days = var.cloudwatch_log_group.publisher_lambda_lgp_retention_in_days
}
