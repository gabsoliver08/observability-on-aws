# Criação do AWS Athena Named Query
resource "aws_athena_named_query" "named_query" {
  name     = "ObservabilityNamedQuery"
  database = aws_glue_catalog_database.database.name
  query_string = <<-EOT
    SELECT * FROM "ObservabilityDatabase"."ObservabilityTable"
  EOT
}