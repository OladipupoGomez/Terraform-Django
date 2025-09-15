resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

resource "aws_secretsmanager_secret" "ssh-key-pair" {
  name                    = "${var.environment}-${var.project}-${var.application}-ssh-key-pair"
  recovery_window_in_days = 0

  tags =  {
    Environment           = var.environment
    Project               = var.project
    Application           = var.application
  }
}

resource "aws_secretsmanager_secret_version" "ssh-key-pair-value" {
  secret_id     = aws_secretsmanager_secret.ssh-key-pair.id
  secret_string = tls_private_key.ssh.private_key_openssh
}

resource "aws_key_pair" "ssh" {
  key_name   = "dev-${var.application}-SSH-key-pair"
  public_key = trimspace(resource.tls_private_key.ssh.public_key_openssh)
}
