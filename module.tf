provider "aws" {
  region     = "us-east-2"
}

resource "random_string" "fqdn" {
  length  = 10
  special = false
  upper   = false
  number  = false
}




module "redshift" {
  source  = "redshift"
  bucket_name = "tf-redshift-${random_string.fqdn.result}"
  bucket_acl = "private"
  bucket_region = "us-east-2"
  bucket_versioning = "false"
  cluster_identifier = "tf-redshift-cluster-${random_string.fqdn.result}"
  database_name      = "testdb"
  master_username    = "admin"
  node_type          = "dc1.large"
  cluster_type       = "single-node"
  tag_environment = "dev"
  tag_owner = "vignesh"
  skip_final_snapshot = true
}
