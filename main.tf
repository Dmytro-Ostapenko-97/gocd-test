provider "aws" {
  version = ">=2.26"
  region = var.aws_region
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
    annotations = {
      name = "test"
    }
  }
}

resource "aws_iam_role" "eks_worker_role" {
  name  = "${var.global_prefix}-workers-role"
  path  = "/"
  tags  = {
    Env = lower(var.env_name)
  }
  lifecycle {
    create_before_destroy = true
  }
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "eks_worker_policy" {
  name = "${var.global_prefix}-workers-role-policy"
  role = aws_iam_role.eks_worker_role.id
  lifecycle {
    create_before_destroy = true
  }
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect":"Allow",
        "Action":[
          "ec2:*",
          "iam:*",
          "s3:*",
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ecr:*",
          "elasticloadbalancing:RegisterTargets"
        ],
        "Resource":"*"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "eks_worker_attach_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker_role.id
}
resource "aws_iam_role_policy_attachment" "eks_worker_attach_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker_role.id
}
resource "aws_iam_role_policy_attachment" "eks_worker_attach_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker_role.id
}

//module "ecr" {
//  source = "git::https://github.com/greg-solutions/terraform_aws_ecr.git"
//  image_tag = "gocd-test-derm"
//  repository_prefix = "gocd-test-derm"
//}
