output "s3_bucket" {
  description = 
  value       = var.s3_bucket
}


output "s3_key" {
  description = "The Amazon S3 key of the deployment package"
  value       = var.s3_key
}
