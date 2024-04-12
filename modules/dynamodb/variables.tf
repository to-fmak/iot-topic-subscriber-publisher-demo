variable "name" {
  type = string
}

variable "billing_mode" {
  type    = string
  default = "PAY_PER_REQUEST"
}

variable "hash_key" {
  type = string
}

variable "range_key" {
  type    = string
  default = null
}

variable "read_capacity" {
  type    = number
  default = null
}

variable "write_capacity" {
  type    = number
  default = null
}

variable "stream_enabled" {
  type    = bool
  default = false
}

variable "stream_view_type" {
  type    = string
  default = null
}

variable "ttl_enabled" {
  type    = bool
  default = false
}

variable "ttl_attribute_name" {
  type    = string
  default = ""
}

variable "point_in_time_recovery_enabled" {
  type    = bool
  default = false
}

variable "attributes" {
  type    = list(map(string))
  default = []
}

variable "tags" {
  type = map(string)
}
