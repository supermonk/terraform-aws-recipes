provider "aws" {
  region = "${var.region}"
}

data "aws_iam_policy_document" "esdomain_policy" {
  statement {
    principals = [
      {
        type = "AWS",
        identifiers = [ "${aws_iam_role.lambda_role.arn}" ]
      }
    ],
    actions = [ "es:*" ],
    resources = [
      "arn:aws:es:::domain/${var.search_domain_name}/*",
      "arn:aws:es:::domain/${var.search_domain_name}"
    ]
  }
  ,statement {
    principals = [
      {
        type = "AWS",
        identifiers = [ "*" ]
      }
    ],
    actions = [ "es:*" ],
    condition {
      test = "IpAddress"
      variable = "aws:SourceIp"
      values = [
        "${var.ip_range_to_access}"
      ]
    },
    resources = [
      "arn:aws:es:::domain/${var.search_domain_name}/*",
      "arn:aws:es:::domain/${var.search_domain_name}"
    ]
  }
}


resource "aws_elasticsearch_domain" "default" {
    domain_name = "${var.search_domain_name}"
    elasticsearch_version = "2.3"
    advanced_options {
        "rest.action.multi.allow_explicit_index" = true
    }
    access_policies = "${data.aws_iam_policy_document.esdomain_policy.json}"
    snapshot_options {
        automated_snapshot_start_hour = "${var.snapshot_time_utc}"
    }

    cluster_config {
        instance_type = "${var.search_instance_type}.elasticsearch",
        instance_count = "${var.search_instance_count}",
        dedicated_master_enabled = "${var.is_search_critical}"
        zone_awareness_enabled = "${var.is_search_critical}"
    }

    ebs_options {
        ebs_enabled = "true"
        volume_size = "10"
        volume_type = "gp2"
    }

    tags {
      Domain = "${var.search_domain_name}",
      Stream = "${var.stream_tag}",
      Name = "${var.search_domain_name}"
    }
}

resource "aws_kinesis_stream" "default" {
    name = "${var.log_stream}"
    shard_count = "${var.stream_shard_count}"
    retention_period = "${var.stream_retention_period}"
    shard_level_metrics = [
        "IncomingBytes",
        "OutgoingBytes"
    ]
    tags {
        Name = "${var.log_stream}",
        Stream = "${var.stream_tag}"
    }
}
