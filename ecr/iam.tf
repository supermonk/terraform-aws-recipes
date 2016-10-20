resource "template_file" "ecr_access_policy" {
  template = "${file("${path.root}/../policies/ecr-access-template.tpl")}"
  vars {
    account_ids = "${var.account_ids}"
  }
}

resource "aws_ecr_repository_policy" "default" {
  repository = "${var.ecr_repo_name}"
  policy   = "${template_file.ecr_access_policy.rendered}"
}
