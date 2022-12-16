
resource "aws_iam_role" "task_execution_role" {

  name               = "${local.prefix}_ecs_task_exec_role_${var.simple_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}



resource "aws_iam_policy" "ecs_extras" {
  name        = "${local.prefix}_ecs_extras_${var.simple_name}"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_iam_role_policy_attachment" "extras" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.ecs_extras.arn
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}