terraform {
  backend "s3" {
    bucket         = "tf-state-113571848071-dev"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}
