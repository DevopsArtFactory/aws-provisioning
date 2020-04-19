## S3 Bucket for storing contents
#resource "aws_s3_bucket" "contents_dayone" {
#  bucket = "${var.account_namespace}-contents-${var.shard_id}"
#
#  versioning {
#    enabled = true
#  }
#
#  # Store logs of access to this bucket will be store in other bucket
#  logging {
#    target_bucket = aws_s3_bucket.apps_logs_bucket.id
#    target_prefix = "${var.account_namespace}-contents-${var.region_namespace}/"
#  }
#
#  # S3 Bucket Policy for allowing access to s3 bucket 
#  policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Sid": "AllowAccessIdentity",
#      "Action": "s3:GetObject",
#      "Effect": "Allow",
#      "Principal": "*",
#      "Resource": "arn:aws:s3:::${var.account_namespace}-contents-${var.shard_id}/*"
#    },
#    {
#      "Sid": "AllowListBucketFromCFwes",
#      "Action": "s3:ListBucket",
#      "Effect": "Allow",
#      "Principal": {
#        "AWS": "${aws_cloudfront_origin_access_identity.dayone_cdn_distribution_origin_access_identity.iam_arn}"
#      },
#      "Resource": "arn:aws:s3:::${var.account_namespace}-contents-${var.shard_id}"
#    }
#  ]
#}
#EOF
#
#  lifecycle_rule {
#    enabled = true
#    transition {
#      days          = 30
#      storage_class = "STANDARD_IA"
#    }
#  }
#
#}
#
## Cloudfront Origin Access Identity 
#resource "aws_cloudfront_origin_access_identity" "dayone_cdn_distribution_origin_access_identity" {
#  comment = "dayone origin access identity in ${var.region_namespace}"
#}
#
## Cloudfront Distribution
#resource "aws_cloudfront_distribution" "dayone_cdn_distribution" {
#
#  origin {
#    domain_name = aws_s3_bucket.contents_dayone.bucket_regional_domain_name
#    origin_id   = "dayone_origin"
#
#    s3_origin_config {
#      # Set origin id created above
#      origin_access_identity = aws_cloudfront_origin_access_identity.dayone_cdn_distribution_origin_access_identity.cloudfront_access_identity_path
#    }
#
#  }
#
#  enabled             = true
#  is_ipv6_enabled     = true
#
#  comment             = "Cloudfront configuration for cdn-contents"
#  default_root_object = "index.html"
#    
#  # Alias of cloudfront distribution
#  #aliases = [var.public_dayone_cdn_domain_name]
#  
#  # Default Cache behavior 
#  default_cache_behavior {
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "dayone_origin"
#    compress         = false
#
#    forwarded_values {
#      query_string = true
#      query_string_cache_keys = ["d"]
#
#      cookies {
#        forward = "all"
#      }
#    }
#
#    # List of Lambda Edge Association
#    #lambda_function_association {
#    #  event_type   = "viewer-request"
#    #  lambda_arn   = "<< Lambda Edge ARN"
#    #  include_body = true
#    #}
#
#    #lambda_function_association {
#    #  event_type   = "origin-response"
#    #  lambda_arn   = "<< Lambda Edge ARN"
#    #  include_body = false
#    #}
#
#    #lambda_function_association {
#    #  event_type = "viewer-response"
#    #  lambda_arn   = "<< Lambda Edge ARN"
#    #  include_body = false
#    #}
#
#    viewer_protocol_policy = "redirect-to-https"
#
#    # cache TTL Setting
#    min_ttl                = 0
#    default_ttl            = 1800
#    max_ttl                = 1800
#
#  }
#  
#  # List of Custom Cache behavior
#  # This behavior will be applied before default
#  ordered_cache_behavior {
#
#    path_pattern           = "*.gif"
#
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "dayone_origin"
#    compress         = false
#
#    viewer_protocol_policy = "redirect-to-https"
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 3600
#
#    forwarded_values {
#      query_string = true
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
#    cloudfront_default_certificate = true
#  }
# 
#  # Cloudfront Logging Settings
#
#  logging_config {
#    include_cookies = false
#    # Set bucket to applitcaion logs you created before
#    bucket          = "dayone-prod-apps-logs-dayonepapne2.s3.amazonaws.com"
#    prefix          = "cdn-contents.dayone.io_access_log/"
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
#    Name = "cdn-contents for dayone CDN"
#  }
#}
