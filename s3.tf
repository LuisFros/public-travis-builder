resource "aws_s3_bucket" "chatroom-generated-pdf" {
    bucket = "chatroom-generated-pdf"
    grant {
                id= "ce13529cf933bb7e30f7171849bb44c26770dc7d8f931bd544485abf5f3441db"
                permissions= [
                  "FULL_CONTROL"
                ]
                type=  "CanonicalUser"
                uri=  ""
              }
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::chatroom-generated-pdf/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "entrega-final-bucket" {
    bucket = "entrega-final-bucket"
    acl    = "private"
    website {
        error_document = "index.html"
        index_document = "index.html"
    } 
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws:s3:::entrega-final-bucket/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "executables-layer-dev-serverlessdeploymentbucket-115sckmg9xl3j" {
    bucket = "executables-layer-dev-serverlessdeploymentbucket-115sckmg9xl3j"
    acl    = "private"
    tags = {
      "STAGE" = "dev"
    }
    server_side_encryption_configuration {
      rule {
         apply_server_side_encryption_by_default {
                  sse_algorithm = "AES256"
          }
      }
    }
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::executables-layer-dev-serverlessdeploymentbucket-115sckmg9xl3j/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "grupo19-code" {
    bucket = "grupo19-code"
    acl    = "private"
    tags = {
      "name" = "grupo19 s3 code bucket"
    }
}

resource "aws_s3_bucket" "htmltopdf-dev-serverlessdeploymentbucket-1ocu9k97ythwv" {
    bucket = "htmltopdf-dev-serverlessdeploymentbucket-1ocu9k97ythwv"
    acl    = "private"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::htmltopdf-dev-serverlessdeploymentbucket-1ocu9k97ythwv/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "mlopez-bucket" {
    bucket = "mlopez-bucket"
    acl    = "private"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws:s3:::mlopez-bucket/*"
    }
  ]
}
POLICY
}

