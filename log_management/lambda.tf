resource "aws_lambda_function" "default" {
    s3_bucket = "${var.lambda_s3_bucket_name}"
    s3_key="package.zip"
    function_name = "${var.lambda_function_name}"
    role = "${aws_iam_role.lambda_role.arn}"
    handler = "index.handleApplicantEvent"
    runtime = "nodejs4.3"
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
    batch_size = 10
    event_source_arn = "${aws_kinesis_stream.default.arn}"
    enabled = true
    function_name = "${aws_lambda_function.default.arn}"
    starting_position = "TRIM_HORIZON"
}
