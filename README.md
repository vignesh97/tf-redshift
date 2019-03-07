# tf-redshift
Terraform redshift


### Create a terraform module that creates the following resources:
- An S3 bucket with private default acl
- A redshift cluster with IAM role that allows read/write access to the bucket

### Input parameters:
- Number of nodes
- Node type/size
- Name of bucket/cluster
- Charge Code tag to be applied to all resources
- Any other parameters you think are required

### Outputs:
- Redshift endpoint
- S3 bucket ARN
- Any other information you think would be useful to have as an output

