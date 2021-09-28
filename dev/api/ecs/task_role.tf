
resource "aws_iam_role" "task_role" {
  name               = "${var.task_container_name}_role"
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


resource "aws_iam_role_policy" "task_policy" {
  name = "${var.task_container_name}_policy"
  role = aws_iam_role.task_role.name

  policy = <<POLICY
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "secretsmanager:GetSecretValue"
         ],
         "Resource":"*"
      }
   ]
}
POLICY
}
