resource "aws_dynamodb_table" "teamjupiter_download_requests" {
  name         = var.teamjupiter_download_requests_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "request_id"

  attribute {
    name = "request_id"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  global_secondary_index {
    name            = "email-created_at-index"
    projection_type = "ALL"

    key_schema {
      attribute_name = "email"
      key_type       = "HASH"
    }

    key_schema {
      attribute_name = "created_at"
      key_type       = "RANGE"
    }
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name    = var.teamjupiter_download_requests_table_name
    app     = "teamjupiter"
    project = "teamjupiter"
    service = "download-request"
    env     = "prod"
  }
}
