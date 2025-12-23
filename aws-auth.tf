resource "kubernetes_config_map_v1" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn = "arn:aws:iam::442880721659:role/prod-eks-eks-node-role"
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes"
        ]
      },
      {
        rolearn = "arn:aws:iam::442880721659:role/github-actions-ecr-role"
        username = "github-actions"
        groups = [
          "system:masters"
        ]
      }
    ])

    mapUsers = yamlencode([
      {
        userarn = "arn:aws:iam::442880721659:user/terraform"
        username = "terraform"
        groups = [
          "system:masters"
        ]
      }
    ])
  }
}
