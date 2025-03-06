variable "aws_account_ids" {
  description = "List of AWS Account IDs to integrate with Spacelift"
  type        = list(string)
}

variable "spacelift_space_id" {
  description = "The Spacelift space to associate AWS accounts with"
  type        = string
}
