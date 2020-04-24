resource "aws_cloudformation_stack" "instance-scheduler" {
  name = "instance-scheduler"

  template_url = "https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/latest/instance-scheduler.template"

}
