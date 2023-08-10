# Criação do AWS Glue Database
resource "aws_glue_catalog_database" "database" {
  name = "ObservabilityDatabase"
}

# Criação da Tabela do AWS Glue
resource "aws_glue_catalog_table" "table" {
  name          = "ObservabilityTable"
  database_name = aws_glue_catalog_database.database.name

  table_type = "EXTERNAL_TABLE"
  parameters = {
    skip.header.line.count = "1"
  }

  storage_descriptor {
    location = aws_s3_bucket.bucket.bucket
    input_format = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    serde_info {
      name = "serde"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }
    columns {
      name = "timestamp"
      type = "string"
    }
    columns {
      name = "message"
      type = "string"
    }
  }
}