# source code for subscriber and publisher lambda functions
data "archive_file" "subscriber_lambda" {
  type        = "zip"
  source_file = "${path.module}/src/subscriber/lambda_function.py"
  output_path = "${path.module}/src/subscriber/lambda_function.zip"
}

data "archive_file" "publisher_lambda" {
  type        = "zip"
  source_file = "${path.module}/src/publisher/lambda_function.py"
  output_path = "${path.module}/src/publisher/lambda_function.zip"
}

# create dynamodb and lambda for iot topic subscriber 
module "subscriber_dynamodb" {
  source = "./modules/dynamodb"

  name       = var.dynamodb.subscriber.name
  hash_key   = var.dynamodb.subscriber.hash_key
  range_key  = var.dynamodb.subscriber.range_key
  attributes = var.dynamodb.subscriber.attributes
  tags       = var.tags
}

module "subscriber_lambda" {
  source = "./modules/lambda_function"

  filename         = data.archive_file.subscriber_lambda.output_path
  function_name    = var.lambda_function.subscriber.function_name
  role             = aws_iam_role.subscriber_lambda_role.arn
  handler          = var.lambda_function.subscriber.handler
  source_code_hash = data.archive_file.subscriber_lambda.output_base64sha256
  runtime          = var.lambda_function.subscriber.runtime
  memory_size      = var.lambda_function.subscriber.memory_size
  timeout          = var.lambda_function.subscriber.timeout
  env_vars         = var.lambda_function.subscriber.env_vars
  tags             = var.tags
}

# create dynamodb and lambda for iot topic publisher
module "publisher_dynamodb" {
  source = "./modules/dynamodb"

  name             = var.dynamodb.publisher.name
  hash_key         = var.dynamodb.publisher.hash_key
  range_key        = var.dynamodb.publisher.range_key
  stream_enabled   = var.dynamodb.publisher.stream_enabled
  stream_view_type = var.dynamodb.publisher.stream_view_type
  attributes       = var.dynamodb.publisher.attributes
  tags             = var.tags
}

module "publisher_lambda" {
  source = "./modules/lambda_function"

  filename         = data.archive_file.publisher_lambda.output_path
  function_name    = var.lambda_function.publisher.function_name
  role             = aws_iam_role.publisher_lambda_role.arn
  handler          = var.lambda_function.publisher.handler
  source_code_hash = data.archive_file.publisher_lambda.output_base64sha256
  runtime          = var.lambda_function.publisher.runtime
  memory_size      = var.lambda_function.publisher.memory_size
  timeout          = var.lambda_function.publisher.timeout
  env_vars         = var.lambda_function.publisher.env_vars
  tags             = var.tags
}
