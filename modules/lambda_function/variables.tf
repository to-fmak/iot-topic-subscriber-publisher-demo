variable "filename" {
  type = string
}

variable "function_name" {
  type = string
}

variable "role" {
  type = string
}

variable "handler" {
  type = string
}

variable "source_code_hash" {
  type = string
}

variable "runtime" {
  type = string
}

variable "memory_size" {
  type = number
}

variable "timeout" {
  type = number
}

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type = map(string)
}
