### Cloudwatch Events ###
# Event rule: Runs at 8pm during working days
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}
resource "aws_iam_role" "ec2_start_stop_scheduler" {
  name = "ec2_start_stop_scheduler"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "ec2_start_stop_scheduler" {
  statement = [
    {
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      resources = [
        "arn:aws:logs:*:*:*",
      ]
    },
    {
      actions = [
        "ec2:Describe*",
        "ec2:Stop*",
        "ec2:Start*"
      ]
      resources = [
          "*",
      ]
    }
  ]
}

resource "aws_iam_policy" "ec2_start_stop_scheduler" {
  name = "ec2_access_scheduler"
  path = "/"
  policy = "${data.aws_iam_policy_document.ec2_start_stop_scheduler.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_access_scheduler" {
  role       = "${aws_iam_role.ec2_start_stop_scheduler.name}"
  policy_arn = "${aws_iam_policy.ec2_start_stop_scheduler.arn}"
}
