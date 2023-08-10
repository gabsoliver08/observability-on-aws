# Criação de roles
resource "aws_iam_role" "logs_role" {
  name = "CloudWatchLogsRole"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "logs.amazonaws.com"
      }
    }]
  })
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