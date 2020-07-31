data "terraform_remote_state" "base_remote_state" {
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = "jackbot-greg-solution-terraform-state"
    key = "base.tfstate"
    region = "us-east-1"
  }
}