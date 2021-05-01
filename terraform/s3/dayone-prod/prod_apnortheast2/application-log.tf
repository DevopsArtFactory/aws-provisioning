# S3 Bucket
resource "aws_s3_bucket" "apps_logs_bucket" {
  bucket = "${var.account_namespace}-prod-apps-logs-${var.shard_id}"
  acl    = "log-delivery-write"

  lifecycle_rule {
    enabled = true

    # You can add any tansition rule 
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "ONEZONE_IA"
    }

    transition {
      days          = 180
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}
