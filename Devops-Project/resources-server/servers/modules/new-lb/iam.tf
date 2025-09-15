data "aws_iam_policy_document" "alb_logs_bucket" {
  statement {
    actions = [
      "s3:GetBucketAcl"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.lb-logs.arn
    ]
     principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::127311923021:root"]
    }
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.lb-logs.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::127311923021:root"]
    }
  }
}

resource "aws_s3_bucket_policy" "alb_logs_bucket" {
  bucket = aws_s3_bucket.lb-logs.id
  policy = data.aws_iam_policy_document.alb_logs_bucket.json
}