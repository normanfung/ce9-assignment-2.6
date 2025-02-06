resource "aws_security_group" "norman_security_group" {
  name        = "norman-sg"
  description = "Allow SSH, HTTP, and HTTPS"
  vpc_id      = aws_vpc.vpc.id

  # Allow SSH (22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to your IP for better security
  }

  # Allow HTTP (80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS (443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "norman-sg"
  }
}


# Creates the IAM policy for dynamodb
resource "aws_iam_policy" "policy" {
  name        = "norman-dynamodb-read-policy-terraform"
  description = "Test policy created using terraform"

  policy = <<EOT
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:DescribeImport",
                "dynamodb:ConditionCheckItem",
                "dynamodb:DescribeContributorInsights",
                "dynamodb:Scan",
                "dynamodb:ListTagsOfResource",
                "dynamodb:Query",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:DescribeGlobalTableSettings",
                "dynamodb:PartiQLSelect",
                "dynamodb:DescribeTable",
                "dynamodb:GetShardIterator",
                "dynamodb:DescribeGlobalTable",
                "dynamodb:GetItem",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeExport",
                "dynamodb:GetResourcePolicy",
                "dynamodb:DescribeKinesisStreamingDestination",
                "dynamodb:DescribeBackup",
                "dynamodb:GetRecords",
                "dynamodb:DescribeTableReplicaAutoScaling"
            ],
            "Resource": "arn:aws:dynamodb:us-east-1:255945442255:table/norman-bookinventory-terraform"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "dynamodb:ListContributorInsights",
                "dynamodb:DescribeReservedCapacityOfferings",
                "dynamodb:ListGlobalTables",
                "dynamodb:ListTables",
                "dynamodb:DescribeReservedCapacity",
                "dynamodb:ListBackups",
                "dynamodb:GetAbacStatus",
                "dynamodb:ListImports",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeEndpoints",
                "dynamodb:ListExports",
                "dynamodb:ListStreams"
            ],
            "Resource": "*"
        }
    ]
}

EOT
}

# Create IAM Role
resource "aws_iam_role" "ec2_dynamodb_role" {
  name = "norman-dynamodb-read-role-terraform"

  # Allow EC2 to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach Policy to IAM Role (Allows Full Access to DynamoDB)
resource "aws_iam_policy_attachment" "ec2_dynamodb_full_access" {
  name       = "norman-ec2-dynamodb-read-attachment"
  roles      = [aws_iam_role.ec2_dynamodb_role.name]
  policy_arn = aws_iam_policy.policy.arn
}

# Create an Instance Profile (Needed for EC2)
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2DynamoDBInstanceProfile"
  role = aws_iam_role.ec2_dynamodb_role.name
}
