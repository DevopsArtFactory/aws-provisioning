# Logs of session manager
# This contains history of commands a user runs while accessing the instance
resource "aws_s3_bucket" "session_manager_logs" {
  bucket = "${var.account_namespace}-prod-sessionmanager-${var.shard_id}"
  acl    = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      # You can use aws/s3 or custom KMS
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
