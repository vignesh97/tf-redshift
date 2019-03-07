variable bucket_name {
  default = "tf-redshift-s3"
}

variable bucket_acl {
  default = "private"
}

variable bucket_region {
  default = "us-east-2"
}

variable bucket_versioning {
  default = false
}

variable cluster_identifier {
  default = "tf-redshift"
}

variable database_name {
  default = "test"
}

variable master_username {
  default = "admin"
}

variable node_type {
  default = "dc1.large"
}

variable cluster_type {
  default = "single-node"
}

variable tag_environment {
  default = "dev"
}
variable tag_owner {
  default = ""
}
variable skip_final_snapshot {
  default = false
}
