provider "aws" {
  region = "us-east-1" # Substitua pela região desejada
}

resource "aws_iam_role" "firehose_role" {
  name = "KinesisFirehoseRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "firehose.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "partition_key_generator" {
  filename         = "lambda_function_app/partition_key_generator.zip" # 
  function_name    = "PartitionKeyGenerator"
  role             = aws_iam_role.firehose_role.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda_function_app/partition_key_generator.zip") # Substitua pelo caminho correto

  environment {
    variables = {
      PARTITION_KEY_PREFIX = "partition_key_prefix"
    }
  }
}


resource "aws_kinesis_firehose_delivery_stream" "firehose" {
  name        = "ObservabilityFirehose"
  destination = "extended_s3"
  role_arn    = aws_iam_role.firehose_role.arn

  extended_s3_configuration {
    bucket_arn         = aws_s3_bucket.bucket.arn
    role_arn           = aws_iam_role.firehose_role.arn
    prefix             = "logs/"
    error_output_prefix = "errors/"
    data_format_conversion_configuration {
      enabled = true
      output_format_configuration {
        serializer {
          orc_serializer {}
        }
      }
    }
    cloudwatch_logging_options {
      enabled = true
      log_group_name = "my-cloudwatch-log-group-name"
    }
  }

  processing_configuration {
    enabled = true
    processors {
      type = "Lambda"
      parameters {
        parameter_name = "LambdaArn"
        parameter_value = aws_lambda_function.partition_key_generator.arn
      }
    }
  }
}
