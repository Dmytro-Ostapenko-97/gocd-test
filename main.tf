provider "aws" {
  version = ">=2.26"
  region = var.aws_region
}

module "ecr" {
  source = "git::https://github.com/greg-solutions/terraform_aws_ecr.git"
  image_tag = "gocd-test-derm"
  repository_prefix = "gocd-test-derm"
}
