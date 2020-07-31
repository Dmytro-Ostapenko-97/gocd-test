variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "gocd-test"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "env_name" {
  default = "dev"
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.base_remote_state.outputs.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.base_remote_state.outputs.eks_cluster_id
}