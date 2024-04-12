resource "aws_lambda_event_source_mapping" "publisher" {
  event_source_arn  = module.publisher_dynamodb.dynamodb_table_stream_arn
  function_name     = module.publisher_lambda.aws_lambda_function_name
  starting_position = "LATEST"
}
