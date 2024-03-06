resource "aws_cloudwatch_event_rule" "instance_rules" {
  for_each = local.instance_rules

  name                = each.value.name
  description         = each.value.description
  schedule_expression = each.value.schedule_expression
}

resource "aws_cloudwatch_event_target" "instance_targets" {
  for_each = local.instance_rules

  rule      = aws_cloudwatch_event_rule.instance_rules[each.key].name
  target_id = "${aws_cloudwatch_event_rule.instance_rules[each.key].name}_target"
  arn       = var.lambda_function_arn

  input_transformer {
    input_paths    = each.value.input_transformer.input_paths
    input_template = each.value.input_transformer.input_template
  }
}

resource "aws_lambda_permission" "instance_eventbridge_permissions" {
  for_each = aws_cloudwatch_event_rule.instance_rules

  statement_id  = "${local.lambda_permission["statement_id"]}${each.value.name}"
  action        = local.lambda_permission["action"]
  principal     = local.lambda_permission["principal"]
  source_arn    = each.value.arn
  function_name = var.function_name
}
