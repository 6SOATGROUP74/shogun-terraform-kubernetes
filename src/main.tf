resource "aws_eks_cluster" "shogun" {
  name     = "shogun_cluster"
  role_arn = [
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "autoscaling:DescribeAutoScalingGroups",
            "autoscaling:UpdateAutoScalingGroup",
            "ec2:AttachVolume",
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:CreateRoute",
            "ec2:CreateSecurityGroup",
            "ec2:CreateTags",
            "ec2:CreateVolume",
            "ec2:DeleteRoute",
            "ec2:DeleteSecurityGroup",
            "ec2:DeleteVolume",
            "ec2:DescribeInstances",
            "ec2:DescribeRouteTables",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeSubnets",
            "ec2:DescribeVolumes",
            "ec2:DescribeVolumesModifications",
            "ec2:DescribeVpcs",
            "ec2:DescribeDhcpOptions",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DescribeAvailabilityZones",
            "ec2:DetachVolume",
            "ec2:ModifyInstanceAttribute",
            "ec2:ModifyVolume",
            "ec2:RevokeSecurityGroupIngress",
            "ec2:DescribeAccountAttributes",
            "ec2:DescribeAddresses",
            "ec2:DescribeInternetGateways",
            "elasticloadbalancing:AddTags",
            "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
            "elasticloadbalancing:AttachLoadBalancerToSubnets",
            "elasticloadbalancing:ConfigureHealthCheck",
            "elasticloadbalancing:CreateListener",
            "elasticloadbalancing:CreateLoadBalancer",
            "elasticloadbalancing:CreateLoadBalancerListeners",
            "elasticloadbalancing:CreateLoadBalancerPolicy",
            "elasticloadbalancing:CreateTargetGroup",
            "elasticloadbalancing:DeleteListener",
            "elasticloadbalancing:DeleteLoadBalancer",
            "elasticloadbalancing:DeleteLoadBalancerListeners",
            "elasticloadbalancing:DeleteTargetGroup",
            "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
            "elasticloadbalancing:DeregisterTargets",
            "elasticloadbalancing:DescribeListeners",
            "elasticloadbalancing:DescribeLoadBalancerAttributes",
            "elasticloadbalancing:DescribeLoadBalancerPolicies",
            "elasticloadbalancing:DescribeLoadBalancers",
            "elasticloadbalancing:DescribeTargetGroupAttributes",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticloadbalancing:DescribeTargetHealth",
            "elasticloadbalancing:DetachLoadBalancerFromSubnets",
            "elasticloadbalancing:ModifyListener",
            "elasticloadbalancing:ModifyLoadBalancerAttributes",
            "elasticloadbalancing:ModifyTargetGroup",
            "elasticloadbalancing:ModifyTargetGroupAttributes",
            "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
            "elasticloadbalancing:RegisterTargets",
            "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
            "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
            "kms:DescribeKey"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "iam:CreateServiceLinkedRole",
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "iam:AWSServiceName" : "elasticloadbalancing.amazonaws.com"
            }
          }
        }
      ]
    }
  ]

  vpc_config {
    subnet_ids = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  }
}