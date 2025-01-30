terraform {
  backend "s3" {
    bucket = ""
    region = "ap-northeast-1"
    key    = "terraform/dev/ap-northeast-1.tfstate"
  }
}
