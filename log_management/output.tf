output "stream_name" {
	value = "${aws_kinesis_stream.default.name}"
}

output "search_domain" {
	value = "aws_elasticsearch_domain.default.domain_id"
}

output "search_endpoint" {
	value = "aws_elasticsearch_domain.default.endpoint"
}