resource "aws_iam_role" "subscriber_lambda_role" {
  name               = "${var.lambda_function.subscriber.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role" "publisher_lambda_role" {
  name               = "${var.lambda_function.publisher.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
