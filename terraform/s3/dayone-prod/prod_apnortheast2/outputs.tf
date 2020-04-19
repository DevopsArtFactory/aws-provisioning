# Bucket name output
output "aws_s3_bucket_application_log" {
  value = aws_s3_bucket.apps_logs_bucket.bucket
}

output "aws_s3_bucket_session-manager_logs" {
  value = aws_s3_bucket.session_manager_logs.bucket
}
