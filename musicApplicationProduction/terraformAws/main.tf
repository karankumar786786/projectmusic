provider "aws" {
  region = "ap-south-1" # As per your previous context
}

# --- 1. SQS Queue ---
resource "aws_sqs_queue" "audio_process_queue" {
  name = "onemelodyaudioprocessteraform"
}

# Allow S3 to send messages to this SQS Queue
resource "aws_sqs_queue_policy" "allow_s3_notification" {
  queue_url = aws_sqs_queue.audio_process_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowS3ToSendMessage"
      Effect    = "Allow"
      Principal = { Service = "s3.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.audio_process_queue.arn
      Condition = {
        ArnLike = {
          "aws:SourceArn" = aws_s3_bucket.temp_bucket.arn
        }
      }
    }]
  })
}

# --- 2. S3 Buckets ---
locals {
  buckets = ["onemelodytempteraform", "onemelodyproductionterraform"]
}

resource "aws_s3_bucket" "temp_bucket" {
  bucket = "onemelodytempteraform"
}

resource "aws_s3_bucket" "prod_bucket" {
  bucket = "onemelodyproductionterraform"
}

# --- 3. Public Access Configuration (Required for both) ---
# This part disables the "Block Public Access" default settings
resource "aws_s3_bucket_public_access_block" "public_access" {
  for_each = toset(local.buckets)
  bucket   = each.value

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  depends_on = [aws_s3_bucket.temp_bucket, aws_s3_bucket.prod_bucket]
}

# This part attaches the policy to allow Public Reads
resource "aws_s3_bucket_policy" "public_read_policy" {
  for_each = toset(local.buckets)
  bucket   = each.value

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "arn:aws:s3:::${each.value}/*"
    }]
  })

  # Ensure the block public access is disabled BEFORE applying the policy
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

# --- 4. S3 Event Notification (Temp Bucket only) ---
resource "aws_s3_bucket_notification" "temp_bucket_notification" {
  bucket = aws_s3_bucket.temp_bucket.id

  queue {
    queue_arn = aws_sqs_queue.audio_process_queue.arn
    events = [
      "s3:ObjectCreated:Put",                    # Standard Uploads
      "s3:ObjectCreated:CompleteMultipartUpload" # Multipart Uploads
    ]
  }


  # Ensure the SQS policy is ready so S3 can verify access immediately
  depends_on = [aws_sqs_queue_policy.allow_s3_notification]
}

# --- 5. CORS Configuration (Allowing Web App CRUD) ---
resource "aws_s3_bucket_cors_configuration" "bucket_cors" {
  for_each = toset(local.buckets)
  bucket   = each.value

  cors_rule {
    # Replace "*" with your actual domain in production for better security
    # e.g., ["https://www.onemelody.com"]
    allowed_origins = ["*"]

    # Allowed methods for CRUD: 
    # GET (Read), PUT/POST (Create/Update), DELETE (Delete)
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]

    # Allow all headers (Authorization, Content-Type, etc.)
    allowed_headers = ["*"]

    # Expose the ETag header so the frontend can verify uploads
    expose_headers = ["ETag"]

    # Cache the preflight (OPTIONS) response for 1 hour (3600 seconds)
    max_age_seconds = 3600
  }

  depends_on = [aws_s3_bucket.temp_bucket, aws_s3_bucket.prod_bucket]
}
