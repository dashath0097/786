terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.0"
    }
  }
}

provider "spacelift" {}

# Read the AWS_ACCOUNT_IDS from environment variables
locals {
  aws_account_ids = jsondecode(get_env("AWS_ACCOUNT_IDS"))
}

resource "spacelift_aws_integration" "developer_aws" {
  for_each = toset(local.aws_account_ids)  # Loop through each AWS account

  name     = "AWS-${each.value}"
  role_arn = "arn:aws:iam::${each.value}:role/Spacelift"
  space_id = var.spacelift_space_id
}

output "integration_ids" {
  value = { for acc_id in local.aws_account_ids : acc_id => spacelift_aws_integration.developer_aws[acc_id].id }
}
