# EC2 IAM Role
resource "aws_iam_role" "ec2" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


# Secrets Manager Read Policy
resource "aws_iam_policy" "rds_secret_read" {
  name = "${var.project_name}-rds-secret-read"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = var.rds_secret_arn
      }
    ]
  })
}

# Attach Secret Read Policy to EC2 Role
resource "aws_iam_role_policy_attachment" "rds_secret_read" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.rds_secret_read.arn
}

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2.name
}