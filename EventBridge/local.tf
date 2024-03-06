
locals {
  instance_rules = {
    stop = {
      name                = "StopInstance"
      description         = "Rule for stop instance EC2"
      schedule_expression = var.turn_off
      input_transformer   = {
        input_paths    = {
          action = "$.detail.state"
        }
        input_template = "{\"action\": \"stop\"}"
      }
    }
    start = {
      name                = "StartInstance"
      description         = "Rule for init instance EC2"
      schedule_expression = var.turn_on
      input_transformer   = {
        input_paths    = {
          action = "$.detail.state"
        }
        input_template = "{\"action\": \"start\"}"
      }
    }
    
  }

  lambda_permission = {
    statement_id = "AllowCloudWatch"
    action       = "lambda:InvokeFunction"
    principal    = "events.amazonaws.com"
  }
}

