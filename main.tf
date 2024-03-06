module "lambda_function" {
  source = "./lambda_function"

  type = var.type

  lambda_function_name = var.lambda_function_name
  handler              = var.handler
  lambda_handler       = var.lambda_handler
  python_ver           = var.python_ver
  source_dir           = var.source_dir
  output_path          = var.output_path
  timeout              = var.timeout
}


module "EventBrige" {
  source = "./EventBridge"

  turn_off = "cron(00 03 * * ? *)"
  turn_on  = "cron(00 10 * * ? *)"

  function_name       = module.lambda_function.function_name
  lambda_function_arn = module.lambda_function.lambda_function_arn
}