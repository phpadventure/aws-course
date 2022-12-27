output "sqs_arn" {
  value = aws_sqs_queue.my-queue.arn
}

output "sqs_url" {
  value = aws_sqs_queue.my-queue.url
}

output "sns_arn" {
  value = aws_sns_topic.my-topic.arn
}