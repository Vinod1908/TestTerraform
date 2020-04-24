### Cloudwatch Events ###
# Event rule: Runs at 8pm during working days
resource "aws_cloudwatch_event_rule" "start_instances_event_rule" {
  name = "start_instances_event_rule"
  description = "Starts stopped EC2 instances"
  schedule_expression = "cron(0 8 ? * MON-FRI *)"
  depends_on = ["aws_lambda_function.ec2_start_scheduler_lambda"]
}

# Runs at 8am during working days
resource "aws_cloudwatch_event_rule" "stop_instances_event_rule" {
  name = "stop_instances_event_rule"
  description = "Stops running EC2 instances"
  schedule_expression = "cron(0 20 ? * MON-FRI *)"
  depends_on = ["aws_lambda_function.ec2_stop_scheduler_lambda"]
}

# Event target: Associates a rule with a function to run
resource "aws_cloudwatch_event_target" "start_instances_event_target" {
  target_id = "start_instances_lambda_target"
  rule = "${aws_cloudwatch_event_rule.start_instances_event_rule.name}"
  arn = "${aws_lambda_function.ec2_start_scheduler_lambda.arn}"
}

resource "aws_cloudwatch_event_target" "stop_instances_event_target" {
  target_id = "stop_instances_lambda_target"
  rule = "${aws_cloudwatch_event_rule.stop_instances_event_rule.name}"
  arn = "${aws_lambda_function.ec2_stop_scheduler_lambda.arn}"
}

# AWS Lambda Permissions: Allow CloudWatch to execute the Lambda Functions
resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_scheduler" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ec2_start_scheduler_lambda.function_name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.start_instances_event_rule.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_scheduler" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ec2_stop_scheduler_lambda.function_name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.stop_instances_event_rule.arn}"
}
