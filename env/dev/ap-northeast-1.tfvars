dynamodb = {
  subscriber = {
    name      = "iot-demo-subscriber-table"
    hash_key  = "TenantID"
    range_key = "Timestamp"
    attributes = [
      {
        name = "TenantID"
        type = "S"
      },
      {
        name = "Timestamp"
        type = "S"
      },
    ]
  }

  publisher = {
    name             = "iot-demo-publisher-table"
    hash_key         = "ClientID"
    range_key        = "Timestamp"
    stream_enabled   = true
    stream_view_type = "NEW_AND_OLD_IMAGES"
    attributes = [
      {
        name = "ClientID"
        type = "S"
      },
      {
        name = "Timestamp"
        type = "S"
      },
    ]
  }
}

tags = {
  env    = "dev"
  region = "ap-northeast-1"
  owner  = "to-fmak"
}

lambda_function = {
  subscriber = {
    function_name = "iot-demo-subscriber-lambda"
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.9"
    memory_size   = "128"
    timeout       = "3"
    env_vars = {
      "TARGET_TABLE" : "iot-demo-subscriber-table"
    }
  }

  publisher = {
    function_name = "iot-demo-publisher-lambda"
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.9"
    memory_size   = "128"
    timeout       = "3"
    env_vars = {
      "TOPIC" : "iot/test/publisher"
    }
  }
}

cloudwatch_log_group = {
  subscriber_lambda_lgp_retention_in_days = 30
  publisher_lambda_lgp_retention_in_days  = 30
}

iot_topic = {
  subscriber = {
    name  = "SubscriberLambdaTest"
    topic = "iot/test/subscriber"
  }

  publisher = {
    name  = "PublisherLambdaTest"
    topic = "iot/test/publisher"
  }
}
