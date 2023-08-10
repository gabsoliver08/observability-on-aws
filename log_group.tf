# Criação do Log Group e Metric Filter
resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/lambda/your-lambda-function-name"
}

resource "aws_cloudwatch_metric_filter" "metric_filter" {
  name           = "YourMetricFilterName"
  pattern        = "{$.status = \"ERROR\"}"
  log_group_name = aws_cloudwatch_log_group.log_group.name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "ObservabilityMetrics"
    value     = "1"
  }
}