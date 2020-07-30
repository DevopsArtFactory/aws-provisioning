resource "aws_s3_bucket" "bucket" {

  bucket = var.domain_name

  website {
    index_document = "index.html"
  }

  versioning {
    enabled = true
  }
  dynamic "cors_rule" {
    for_each = var.s3_cors_rules == null ? [] : var.s3_cors_rules

    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAccessIdentity",
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_cloudfront_origin_access_identity.identity.iam_arn}"
      },
      "Resource": "arn:aws:s3:::${var.domain_name}/*"
    },
    {
      "Sid": "AllowAccessIdentityListBucket",
      "Action": "s3:ListBucket",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_cloudfront_origin_access_identity.identity.iam_arn}"
      },
      "Resource": "arn:aws:s3:::${var.domain_name}"
    }
  ]
}
EOF

}

resource "aws_cloudfront_origin_access_identity" "identity" {
  comment = "access-identity-benx-${var.service_name}-${var.domain_name}"
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = var.service_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  comment             = "Cloudfront configuration for ${var.domain_name}"
  default_root_object = "redirect.html"

  web_acl_id = var.web_acl_id

  aliases = var.cnames

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.service_name
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_external_ssl_certificate_arn
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method       = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl = 5
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }
}

resource "aws_route53_record" "record" {
  count = length(var.cnames)
  zone_id = var.route53_external_zone_id
  name    = var.cnames[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}
