module "lambda-scheduler" {
  source = "neillturner/lambda-scheduler/aws"
  version = "0.x.0"
  schedule_expression = "cron(5 * * * ? *)"
  tag = "schedule"
  schedule_tag_force = "true"
  ec2_schedule = "true"
  rds_schedule = "true"
  default = "{\"mon\": {\"start\": [7], \"stop\": [19]},\"tue\": {\"start\": [7], \"stop\": [19]},\"wed\": {\"start\": [9, 22], \"stop\": [19]},\"thu\": {\"start\": [7], \"stop\": [2,19]}, \"fri\": {\"start\": [18], \"stop\": [9]}, \"sat\": {\"start\": [22]}, \"sun\": {\"stop\": [7]}}"
  time = "Asia/Kolkata"
}
