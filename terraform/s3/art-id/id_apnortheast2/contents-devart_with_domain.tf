## S3 Bucket for storing contents
#resource "aws_s3_bucket" "contents_devart" {
#  bucket = "${var.account_namespace}-contents-${var.shard_id}"
#}
#
#resource "aws_s3_bucket_public_access_block" "contents_devart" {
#  bucket = aws_s3_bucket.contents_devart.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}
#
#resource "aws_s3_bucket_cors_configuration" "contents_devart" {
#  bucket = aws_s3_bucket.contents_devart.id
#
#  cors_rule {
#    allowed_headers = ["*"]
#    allowed_methods = ["GET", "HEAD"]
#    allowed_origins = ["*"]
#    expose_headers  = ["ETag"]
#    max_age_seconds = 3000
#  }
#}
#
#resource "aws_s3_bucket_versioning" "contents_devart" {
#  bucket = aws_s3_bucket.contents_devart.id
#  versioning_configuration {
#    status = "Enabled"
#  }
#}
#
#resource "aws_s3_bucket_accelerate_configuration" "contents_devart" {
#  bucket = aws_s3_bucket.contents_devart.id
#  status = "Enabled"
#}
#
#resource "aws_s3_bucket_policy" "contents_devart" {
#  bucket = aws_s3_bucket.contents_devart.id
#  policy = data.aws_iam_policy_document.contents_devart.json
#}
#
#data "aws_iam_policy_document" "contents_devart" {
#  statement {
#    principals {
#      type        = "Service"
#      identifiers = ["cloudfront.amazonaws.com"]
#    }
#
#    condition {
#      test     = "StringEquals"
#      variable = "AWS:SourceArn"
#      values = [
#        aws_cloudfront_distribution.devart_cdn_distribution.arn,
#      ]
#    }
#
#    actions   = ["s3:GetObject"]
#    resources = ["${aws_s3_bucket.contents_devart.arn}/*"]
#  }
#}
#
#resource "aws_s3_bucket_lifecycle_configuration" "contents_devart" {
#  bucket = aws_s3_bucket.contents_devart.id
#
#  rule {
#    id     = "contents_devart_rule"
#    status = "Enabled"
#
#    transition {
#      days          = 30
#      storage_class = "STANDARD_IA"
#    }
#  }
#}
#
#resource "aws_cloudfront_origin_access_control" "devart_contents" {
#  name                              = "devart-contents"
#  origin_access_control_origin_type = "s3"
#  signing_behavior                  = "always"
#  signing_protocol                  = "sigv4"
#}
#
## Cloudfront Distribution
#resource "aws_cloudfront_distribution" "devart_cdn_distribution" {
#  origin {
#    domain_name              = aws_s3_bucket.contents_devart.bucket_regional_domain_name
#    origin_id                = "devart_origin"
#    origin_access_control_id = aws_cloudfront_origin_access_control.devart_contents.id
#  }
#
#  enabled         = true
#  is_ipv6_enabled = true
#  comment         = "Cloudfront configuration for cdn"
#  http_version    = "http2and3"
#
#  # Alias of cloudfront distribution
#  aliases = ["cdn.devops-art-factory.com"]
#
#  # Default Cache behavior
#  default_cache_behavior {
#    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "devart_origin"
#    compress         = true
#
#    forwarded_values {
#      query_string = false
#
#      cookies {
#        forward = "all"
#      }
#    }
#
#    viewer_protocol_policy = "redirect-to-https"
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 86400
#  }
#
#  # List of Custom Cache behavior
#  # This behavior will be applied before default
#  ordered_cache_behavior {
#
#    path_pattern = "*.gif"
#
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "devart_origin"
#    compress         = false
#
#    viewer_protocol_policy = "redirect-to-https"
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 3600
#
#    forwarded_values {
#      query_string            = true
#      query_string_cache_keys = ["d"]
#
#      cookies {
#        forward = "all"
#      }
#    }
#  }
#
#  restrictions {
#    geo_restriction {
#      restriction_type = "none"
#    }
#  }
#
#  # Certification Settings
#  viewer_certificate {
#    acm_certificate_arn      = "..."
#    minimum_protocol_version = "TLSv1.1_2016"
#    ssl_support_method       = "sni-only"
#  }
#
#  # You can set custom error response
#  custom_error_response {
#    error_caching_min_ttl = 5
#    error_code            = 404
#    response_code         = 404
#    response_page_path    = "/404.html"
#  }
#
#  custom_error_response {
#    error_caching_min_ttl = 5
#    error_code            = 500
#    response_code         = 500
#    response_page_path    = "/500.html"
#  }
#
#  custom_error_response {
#    error_caching_min_ttl = 5
#    error_code            = 502
#    response_code         = 502
#    response_page_path    = "/500.html"
#  }
#
#  # Tags of cloudfront
#  tags = {
#    Name = "cdn.devops-art-factory.com"
#  }
#}
#
## Route 53 Record for cloudfront
#resource "aws_route53_record" "devart_cdn" {
#  zone_id = "..."
#  name    = "cdn.devops-art-factory.com"
#  type    = "A"
#
#  alias {
#    name                   = aws_cloudfront_distribution.devart_cdn_distribution.domain_name
#    zone_id                = "Z2FDTNDATAQYW2" # This is fixed value!
#    evaluate_target_health = false
#  }
#}
#
