output "primary_queue" {
  description = "The primary queue created by this module"
  value       = aws_sqs_queue.primary
}
