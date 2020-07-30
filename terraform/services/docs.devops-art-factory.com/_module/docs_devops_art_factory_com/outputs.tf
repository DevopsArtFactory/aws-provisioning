output "aws_cloudfront_distribution_docs_devops_art_factory_com_id" {
  value = aws_cloudfront_distribution.distribution.id
}

output "aws_s3_bucket_docs_devops_art_factory_com_bucket" {
  value = aws_s3_bucket.bucket.bucket
}
