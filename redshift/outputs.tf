output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "bucket_arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}

output "redshift-role" {
  value = "${aws_iam_role.redshift_s3_access_role.arn}"
}

output "cluster_id" {
  value = "${aws_redshift_cluster.default.id}"
}
output "cluster_endpoint" {
  value = "${aws_redshift_cluster.default.endpoint}"
}
output "cluster_dns_name" {
  value = "${aws_redshift_cluster.default.dns_name}"
}
output "cluster_port" {
  value = "${aws_redshift_cluster.default.port}"
}
output "cluster_version" {
  value = "${aws_redshift_cluster.default.cluster_version}"
}
output "cluster_master_password" {
  value = "${aws_redshift_cluster.default.master_password}"
}

