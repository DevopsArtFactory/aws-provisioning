resource "aws_s3_bucket" "teamjupiter_downloads" {
  bucket = "${var.account_namespace}-teamjupiter-downloads-${var.shard_id}"

  tags = {
    Name    = "${var.account_namespace}-teamjupiter-downloads-${var.shard_id}"
    app     = "teamjupiter"
    project = "teamjupiter"
    service = "download-artifacts"
    env     = "prod"
  }
}

resource "aws_s3_bucket_public_access_block" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = var.teamjupiter_download_allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id

  rule {
    id     = "abort-incomplete-multipart-upload"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_policy" "teamjupiter_downloads" {
  bucket = aws_s3_bucket.teamjupiter_downloads.id
  policy = data.aws_iam_policy_document.teamjupiter_downloads_bucket_policy.json
}

data "aws_iam_policy_document" "teamjupiter_downloads_bucket_policy" {
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]

    resources = [
      aws_s3_bucket.teamjupiter_downloads.arn,
      "${aws_s3_bucket.teamjupiter_downloads.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
