
resource "random_string" "password" {
 length = 16
 special = true
  upper = true
  number = true
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Environment = "${var.tag_environment}"
    Owner   = "${var.tag_owner}"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "${var.bucket_acl}"
  region = "${var.bucket_region}"
  versioning {
    enabled = "${var.bucket_versioning}"
  }
  tags = "${local.common_tags}"
  force_destroy = true
}

resource "random_string" "fqdn" {
  length  = 5
  special = false
  upper   = false
  number  = false
}

resource "aws_iam_role" "redshift_s3_access_role" {
  name               = "redshift-s3-role-${random_string.fqdn.result}"
  assume_role_policy = "${file("${path.module}/assume-policy.json")}"
  tags = "${local.common_tags}"
}

data "template_file" "s3_policy_template" {
    template = "${file("${path.module}/s3-policy.json.tpl")}"
    vars {
      bucket_arn    = "${aws_s3_bucket.bucket.arn}"
    }
}


resource "aws_iam_policy" "s3-policy" {
  name        = "s3-bucket-policy-${random_string.fqdn.result}"
  description = "S3 bucket red write access"
  policy      = "${data.template_file.s3_policy_template.rendered}"
}

resource "aws_iam_policy_attachment" "s3-policy-attach" {
  name       = "s3-policy-attach-${random_string.fqdn.result}"
  roles      = ["${aws_iam_role.redshift_s3_access_role.name}"]
  policy_arn = "${aws_iam_policy.s3-policy.arn}"
}

resource "aws_redshift_cluster" "default" {
  cluster_identifier = "${var.cluster_identifier}"
  database_name      = "${var.database_name}"
  master_username    = "${var.master_username}"
  master_password    = "${random_string.password.result}"
  node_type          = "${var.node_type}"
  cluster_type       = "${var.cluster_type}"
  iam_roles = ["${aws_iam_role.redshift_s3_access_role.arn}"]
   tags = "${local.common_tags}"
}
