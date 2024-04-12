resource "aws_iot_topic_rule" "subscriber" {
  name        = var.iot_topic.subscriber.name
  enabled     = true
  sql         = "SELECT * FROM '${var.iot_topic.subscriber.topic}'"
  sql_version = "2016-03-23"

  lambda {
    function_arn = module.subscriber_lambda.aws_lambda_function_arn
  }
}

resource "aws_lambda_permission" "iot_topic_rule_permission" {
  action        = "lambda:InvokeFunction"
  function_name = module.subscriber_lambda.aws_lambda_function_name
  principal     = "iot.amazonaws.com"
  source_arn    = aws_iot_topic_rule.subscriber.arn
}

resource "aws_iot_topic_rule" "publisher" {
  name        = var.iot_topic.publisher.name
  enabled     = true
  sql         = "SELECT * FROM '${var.iot_topic.publisher.topic}'"
  sql_version = "2016-03-23"
}
