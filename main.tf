provider "aws" {
  version = ">=2.26"
  region = var.aws_region
}

provider "kubectl" {
  host = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token = data.aws_eks_cluster_auth.cluster.token
  load_config_file = false
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
    annotations = {
      name = "test"
    }
  }
}

//module "ecr" {
//  source = "git::https://github.com/greg-solutions/terraform_aws_ecr.git"
//  image_tag = "gocd-test-derm"
//  repository_prefix = "gocd-test-derm"
//}
