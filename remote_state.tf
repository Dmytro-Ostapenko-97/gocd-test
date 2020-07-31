data "terraform_remote_state" "base_remote_state" {
  backend = "s3"
  config = {
    bucket = "jackbot-greg-solution-terraform-state"
    key = "base.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "kube_remote_state" {
  backend = "s3"
  config = {
    bucket = "jackbot-greg-solution-terraform-state"
    key = "kube-dev.tfstate"
    region = "us-east-1"
  }
}