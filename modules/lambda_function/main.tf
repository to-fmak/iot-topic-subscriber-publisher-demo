resource "aws_lambda_function" "this" {
  filename      = var.filename
  function_name = var.function_name
  role          = var.role
  handler       = var.handler

  source_code_hash = var.source_code_hash

  runtime = var.runtime

  memory_size = var.memory_size
  timeout     = var.timeout

  dynamic "environment" {
    for_each = length(keys(var.env_vars)) == 0 ? [] : [true]
    content {
      variables = var.env_vars
    }
  }

  tags = {
    Name        = var.function_name
    Environment = var.tags.env
    Region      = var.tags.region
    Owner       = var.tags.owner
  }
}
