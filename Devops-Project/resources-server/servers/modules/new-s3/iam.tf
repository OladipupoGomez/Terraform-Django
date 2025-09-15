data "aws_iam_policy_document" "server-bucket-access" {
  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "${aws_s3_bucket.server_s3.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      aws_s3_bucket.server_s3.arn
    ]
  }

  statement {
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "server-bucket-access" {
  name   = "${var.project}-${var.application}-exports-bucket-access-${var.environment}-iam-policy"
  path   = "/applications/${var.project}/${var.application}/${var.environment}/"
  policy = data.aws_iam_policy_document.server-bucket-access.json
}

resource "aws_iam_role_policy_attachment" "server-bucket-access" {
  role       = var.iam_role_name
  policy_arn = aws_iam_policy.server-bucket-access.arn
}