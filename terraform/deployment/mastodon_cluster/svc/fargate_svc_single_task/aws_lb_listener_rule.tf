

resource "aws_lb_listener_rule" "rule" {
  count = var.container_port == null ? 0 : 1

  # (Required, Forces New Resource) The ARN of the listener to which to attach the rule.
  listener_arn = var.listener_arn

  # (Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically 
  # set the rule with next available priority after currently existing highest rule. 
  # A listener can't have multiple rules with the same priority.
  priority = var.route_priority

  # (Required) An Action block. Action blocks are documented below.
  action {

    # (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc.
    type = "forward"

    # (Optional) The ARN of the Target Group to which to route traffic.
    # Specify only if type is forward and you want to route to a single target group.
    # To route to one or more target groups, use a forward block instead.
    target_group_arn = aws_lb_target_group.tg[0].arn

    # (Optional) Information for creating an action that distributes requests among one or more target groups. 
    # Specify only if type is forward. If you specify both forward block and target_group_arn attribute, you can 
    # specify only one target group using forward and it must be the same target group specified in target_group_arn.
    # forward {}

    # (Optional) Information for creating a redirect action. Required if type is redirect.
    # redirect {}

    # (Optional) Information for creating an action that returns a custom HTTP response. Required if type is fixed-response.
    # fixed_response {}

    # (Optional) Information for creating an authenticate action using Cognito. Required if type is authenticate-cognito.
    # authenticate_cognito {}

    # (Optional) Information for creating an authenticate action using OIDC. Required if type is authenticate-oidc.
    # authenticate_oidc {}
  }

  # (Required) A Condition block. Multiple condition blocks of different types can be set and 
  # all must be satisfied for the rule to match. Condition blocks are documented below.
  condition {

    # (Optional) Contains a single values item which is a list of path patterns to match against the request URL.
    # Maximum size of each pattern is 128 characters. Comparison is case sensitive. 
    # Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). 
    # Only one pattern needs to match for the condition to be satisfied. 
    # Path pattern is compared only to the path of the URL, not to its query string. 
    # To compare against the query string, use a query_string condition.        
    dynamic "path_pattern" {
      for_each = var.path_pattern == null ? [] : [var.path_pattern]
      content {
        values = [path_pattern.value]
      }
    }
  }

  # (Optional) A map of tags to assign to the resource. 
  # If configured with a provider default_tags configuration block present, 
  # tags with matching keys will overwrite those defined at the provider-level.
  tags = null
}
