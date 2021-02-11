terraform {
  backend "s3" {
    bucket = "squids-tf-state"
    key = "us-west-2/vpc.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}
