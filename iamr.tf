resource "aws_iam_role" "aws-ec2-spot-fleet-tagging-role" {
    name               = "aws-ec2-spot-fleet-tagging-role"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "spotfleet.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "aws-opsworks-ec2-role" {
    name               = "aws-opsworks-ec2-role"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "aws-opsworks-service-role" {
    name               = "aws-opsworks-service-role"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "opsworks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSDataLifecycleManagerDefaultRole" {
    name               = "AWSDataLifecycleManagerDefaultRole"
    path               = "/service-role/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForAutoScaling" {
    description        = "Default Service-Linked Role enables access to AWS Services and Resources used or managed by Auto Scaling"
    name               = "AWSServiceRoleForAutoScaling"
    path               = "/aws-service-role/autoscaling.amazonaws.com/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role" "AWSServiceRoleForElasticLoadBalancing" {
    description           = "Allows ELB to call AWS services on your behalf."
    name               = "AWSServiceRoleForElasticLoadBalancing"
    path               = "/aws-service-role/elasticloadbalancing.amazonaws.com/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticloadbalancing.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForRDS" {
  description           = "Allows Amazon RDS to manage AWS resources on your behalf"
    name               = "AWSServiceRoleForRDS"
    path               = "/aws-service-role/rds.amazonaws.com/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForSupport" {
  description           = "Enables resource access for AWS to provide billing, administrative and support services"
    name               = "AWSServiceRoleForSupport"
    path               = "/aws-service-role/support.amazonaws.com/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "support.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForTrustedAdvisor" {
   description           = "Access for the AWS Trusted Advisor Service to help reduce cost, increase performance, and improve security of your AWS environment." 
    name               = "AWSServiceRoleForTrustedAdvisor"
    path               = "/aws-service-role/trustedadvisor.amazonaws.com/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "trustedadvisor.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}



resource "aws_iam_role" "dsa-role-nzu0tal0" {
    name               = "dsa-role-nzu0tal0"
    path               = "/service-role/"
    tags = {
      "STAGE" = "dev"
    }
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "GetStartedLambdaBasicExecutionRole" {
  description           = "Allows Lambda functions to call AWS services on your behalf." 
    name               = "GetStartedLambdaBasicExecutionRole"
    path               = "/service-role/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "htmlToPdf-dev-us-east-1-lambdaRole" {
    name               = "htmlToPdf-dev-us-east-1-lambdaRole"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "iamrole-codedeploy" {
   description           = "Allows CodeDeploy to call AWS services such as Auto Scaling on your behalf."
    name               = "iamrole-codedeploy"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "lambdawiths3service" {
    description           = "Allows Lambda functions to call AWS services on your behalf." 
    name               = "lambdawiths3service"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "NewRelicInfrastructure-Integrations" {
    name               = "NewRelicInfrastructure-Integrations"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::754728514883:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "2957562"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role" "NewRelicInfrastructure-Integrations-2" {
    name               = "NewRelicInfrastructure-Integrations-2"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::754728514883:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "2957562"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role" "rds-monitoring-role" {
    name               = "rds-monitoring-role"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "monitoring.rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "sendEmailRole" {
    name               = "sendEmailRole"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "travisProgramatic" {
    description           = "Allows EC2 instances to call AWS services on your behalf."
    name               = "travisProgramatic"
    path               = "/"
    tags = {
      "name" = "travis"
    }
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

