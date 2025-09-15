data "aws_iam_policy_document" "ec2-assume-role-policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "server" {
  name               = "${var.project}-${var.application}-${var.environment}-iam-role"
  path               = "/applications/${var.project}/${var.application}/${var.environment}/server-iam-role/"
  assume_role_policy = data.aws_iam_policy_document.ec2-assume-role-policy.json

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

data "aws_iam_policy_document" "secrets-access" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["arn:aws:secretsmanager:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:secret:infra/secrets/${var.environment}/credentials*"]
  }
}

resource "aws_iam_policy" "server" {
  name = "${var.project}-${var.application}-${var.environment}-iam-policy"
  path = "/applications/${var.project}/${var.application}/${var.environment}/server-iam-policy/"

  policy = data.aws_iam_policy_document.secrets-access.json
}

resource "aws_iam_role_policy_attachment" "server-policy" {
  role       = aws_iam_role.server.name
  policy_arn = aws_iam_policy.server.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch-policy-attach" {
  role       = aws_iam_role.server.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "server" {
  name = "${var.project}-${var.application}-${var.environment}-iam-profile"
  path = "/applications/${var.project}/${var.application}/${var.environment}/server-iam-profile/"
  role = aws_iam_role.server.name

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}