variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ca-central-1"
}

variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone."
  type        = string
  default     = "benoit-blais.sbx.hashidemos.io"
}

variable "acme_challenges" {
  description = "A map of ACME DNS-01 challenges for different certificates. The key is the record prefix (e.g., '_acme-challenge.app') and the value is a list of TXT tokens."
  type        = map(list(string))
  default     = {}
}