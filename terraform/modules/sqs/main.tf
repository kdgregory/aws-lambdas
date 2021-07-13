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

  has_dlq                     = (var.retry_count != null) ? toset(["1"]) : toset([])
  dlq_retention_days          = (var.dlq_retention_days != null) ? var.dlq_retention_days : var.message_retention_days
  redrive_policy              = (var.retry_count != null) ? jsonencode({
                                  deadLetterTargetArn = aws_sqs_queue.dlq["1"].arn
                                  maxReceiveCount     = var.retry_count
                                  }) : null
}


data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


resource "aws_sqs_queue" "primary" {
  name                        = var.name
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = floor(var.message_retention_days * 86400)
  redrive_policy              = local.redrive_policy
}


resource "aws_sqs_queue" "dlq" {
  for_each                    = local.has_dlq
  name                        = "${var.name}-dlq"
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = floor(local.dlq_retention_days * 86400)
}
