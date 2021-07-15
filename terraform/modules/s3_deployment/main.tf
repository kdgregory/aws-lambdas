terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.40.0"
    }
  }
}


locals {
  do_upload   = var.overwrite || (length(data.aws_s3_bucket_objects.existing.keys) == 0)
  etag        = local.do_upload ? filemd5(var.source) : null
}


data "aws_s3_bucket_objects" "existing" {
  bucket      = var.s3_bucket
  prefix      = var.s3_key
}


resource "aws_s3_bucket_object" "object" {
  bucket    = var.s3_bucket
  key       = var.s3_key
  source    = var.source
  etag      = local.etag
}