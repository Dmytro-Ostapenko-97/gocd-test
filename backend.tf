terraform {
  required_version = "= 0.12.28"
  backend "s3" {
    bucket = "jackbot-greg-solution-terraform-state"
#    key = "gocd-test.tfstate"
    region = "us-east-1"
    //dynamodb_table = "terraform-remote-state-lock-db"
  }
}
