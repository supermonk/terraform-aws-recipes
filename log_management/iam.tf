data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetRecords",
      "kinesis:GetShardIterator"
    ],
    resources = [
      "${aws_kinesis_stream.default.arn}"
    ]
  },
  statement {
    actions = [
      "es:DescribeElasticsearchDomain",
      "es:DescribeElasticsearchDomains",
      "es:DescribeElasticsearchDomainConfig",
      "es:ListDomainNames",
      "es:ListTags"
    ],
    resources = [
      "${aws_elasticsearch_domain.default.arn}/*"
    ]
  },
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ],
    resources = [ "*" ]
  },
  statement {
    actions = [ "lambda:InvokeFunction" ],
    resources = [
      "arn:aws:lambda:::function:${var.lambda_function_name}"
    ]
  },
  statement {
    actions = [ "kinesis:ListStreams" ],
    resources = [ "arn:aws:kinesis:::stream/*" ]
  }
}

resource "aws_iam_policy" "default" {
    name = "logs_lambda_policy"
    path = "/"
    policy = "${data.aws_iam_policy_document.default.json}"
}

resource "aws_iam_role" "lambda_role" {
    name = "${var.lambda_function_name}-lambda-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "default" {
  name = "logs_lambda_policy_attachment"
  policy_arn = "${aws_iam_policy.default.arn}"
  roles = ["${aws_iam_role.lambda_role.name}"]
}
