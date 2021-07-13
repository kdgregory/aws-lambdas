terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.40.0"
    }
  }
}


locals {
  aws_account_id              = data.aws_caller_identity.current.account_id
  aws_region                  = data.aws_region.current.name
}


data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


resource "aws_sqs_queue" "primary" {
  name                        = var.name
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = floor(var.message_retention_days * 86400)
}


