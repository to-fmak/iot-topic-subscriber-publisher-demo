variable "dynamodb" {
  type = any
}

variable "tags" {
  type = map(string)
}

variable "lambda_function" {
  type = map(any)
}

variable "cloudwatch_log_group" {
  type = map(number)
}

variable "iot_topic" {
  type = map(any)
}
