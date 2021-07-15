variable "s3_bucket" {
  description = "The bucket where the deployment bundle is/should be stored"
  type        = string
  default     = null
}

variable "s3_key" {
  description = "The Amazon S3 key of the deployment package"
  type        = string
  default     = null
}

variable "source" {
  description = "The name of a local file containing the deployment bundle"
  type        = string
}

variable "overwrite" {
  description = "If true, overwrite an existing bundle"
  type        = bool
  default     = false
}
