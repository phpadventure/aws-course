#####SQS########
resource "aws_sqs_queue" "my-queue" {
  name                      = var.sqs_name
  delay_seconds             = 10
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0
}

#####SNS########
resource "aws_sns_topic" "my-topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "my-topic-subscription" {
  topic_arn = aws_sns_topic.my-topic.arn
  protocol  = "email"
  endpoint  = var.email_to_subscribe
}
