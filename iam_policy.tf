data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# for iot topic subscriber lambda 
data "aws_iam_policy_document" "subscriber_lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_function.subscriber.function_name}:*"
    ]
  }
  statement {
    actions = [
      "dynamodb:PutItem",
    ]
    resources = [
      module.subscriber_dynamodb.dynamodb_table_arn,
    ]
  }
}

resource "aws_iam_policy" "subscriber_lambda_policy" {
  name   = "${var.lambda_function.subscriber.function_name}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.subscriber_lambda_policy.json
}

resource "aws_iam_policy_attachment" "subscriber" {
  name       = var.lambda_function.subscriber.function_name
  roles      = [aws_iam_role.subscriber_lambda_role.name]
  policy_arn = aws_iam_policy.subscriber_lambda_policy.arn
}

# for iot topic publisher lambda 
data "aws_iam_policy_document" "publisher_lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_function.publisher.function_name}:*"
    ]
  }
  statement {
    actions = [
      "iot:Publish",
    ]
    resources = [
      "arn:aws:iot:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:topic/${var.iot_topic.publisher.topic}",
    ]
  }

  statement {
    actions = [
      "dynamodb:GetShardIterator",
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords"
    ]
    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb.publisher.name}/stream/*",
    ]
  }

  statement {
    actions = [
      "dynamodb:ListStreams",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "publisher_lambda_policy" {
  name   = "${var.lambda_function.publisher.function_name}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.publisher_lambda_policy.json
}

resource "aws_iam_policy_attachment" "publisher" {
  name       = var.lambda_function.publisher.function_name
  roles      = [aws_iam_role.publisher_lambda_role.name]
  policy_arn = aws_iam_policy.publisher_lambda_policy.arn
}
