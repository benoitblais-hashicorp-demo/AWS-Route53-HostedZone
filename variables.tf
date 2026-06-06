variable "vpc_id" {
  description = "(Required) The ID of the VPC to associate with the private local hosted zone."
  type        = string
}

variable "acme_challenges" {
  description = "(Optional) A map of ACME DNS-01 challenges for different certificates. The key is the record prefix (e.g., '_acme-challenge.app') and the value is a list of TXT tokens."
  type        = map(list(string))
  default     = {}
}

variable "aws_region" {
  description = "(Optional) The AWS region to deploy resources into."
  type        = string
  default     = "ca-central-1"
}

variable "domain_name" {
  description = "(Optional) The domain name for the public Route 53 hosted zone."
  type        = string
  default     = "benoit-blais.sbx.hashidemos.io"
}

variable "local_domain_name" {
  description = "(Optional) The domain name for the private local Route 53 hosted zone."
  type        = string
  default     = "benoit-blais.sbx.hashidemos.local"
}