resource "aws_iam_role" "execution_role" {
  name               = "${var.task_definition_family_name}_execution_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Terraform = true
  }
}

resource "aws_iam_role_policy" "execution_policy" {
  name = "${var.task_definition_family_name}_execution_policy"

  role = aws_iam_role.execution_role.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
POLICY
}
