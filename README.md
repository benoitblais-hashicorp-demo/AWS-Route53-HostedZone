# AWS-Route53-HostedZone
Code to configure and manage DNS records and domain settings in AWS Route 53.

<!-- BEGIN_TF_DOCS -->
# AWS Route 53 Hosted Zone

This code is used to manage DNS records for an existing public AWS Route 53 hosted zone and create a private local Route 53 hosted zone for internal network resolution.

## Permissions

To provision the AWS resources managed by this code, the IAM role or user running Terraform needs permissions such as:

- `route53:CreateHostedZone`
- `route53:DeleteHostedZone`
- `route53:GetHostedZone`
- `route53:ChangeResourceRecordSets`
- `route53:ListResourceRecordSets`
- `route53:ListTagsForResource`
- `route53:ChangeTagsForResource`

## Authentications

Authentication to AWS can be configured using one of the following methods, with preference given to OIDC and dynamic provider credentials in CI/CD environments.

### HCP Terraform / Terraform Enterprise Dynamic Credentials (OIDC)

Use dynamic provider credentials via OpenID Connect (OIDC) for secure, short-lived credentials when running in HCP Terraform or Terraform Enterprise.

- **Using environment variables (HCP Terraform Workspace)**
  - `TFC_AWS_PROVIDER_AUTH=true`
  - `TFC_AWS_RUN_ROLE_ARN=<aws-iam-role-arn>`

### OIDC with GitHub Actions

When using GitHub Actions, configure OIDC via the `aws-actions/configure-aws-credentials` action.

- **Using GitHub Actions**

  ```yaml
  - name: Configure AWS credentials
    uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::111122223333:role/github-actions-role
      aws-region: ca-central-1
  ```

### Static Access Keys

For local development or environments not supporting OIDC, use static IAM programmatic access keys.

- **Inside the provider block**

  ```hcl
  provider "aws" {
    region     = "ca-central-1"
    access_key = "<aws-access-key-id>"
    secret_key = "<aws-secret-access-key>"
  }
  ```

- **Using environment variables**
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

## Features

- Looks up an existing public AWS Route 53 Hosted Zone.
- Provisions a private local AWS Route 53 Hosted Zone attached to a specified VPC.
- Configures a CAA record to exclusively allow Let's Encrypt and GlobalSign to issue SSL/TLS certificates for the public domain and its subdomains.
- Automates creation of Let's Encrypt/GlobalSign DNS-01 ACME challenge TXT records for dynamic certificate validation.

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.7)

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (~> 5.0)

## Modules

No modules.

## Required Inputs

The following input variables are required:

### <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)

Description: (Required) The ID of the VPC to associate with the private local hosted zone.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_acme_challenges"></a> [acme\_challenges](#input\_acme\_challenges)

Description: (Optional) A map of ACME DNS-01 challenges for different certificates. The key is the record prefix (e.g., '\_acme-challenge.app') and the value is a list of TXT tokens.

Type: `map(list(string))`

Default: `{}`

### <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region)

Description: (Optional) The AWS region to deploy resources into.

Type: `string`

Default: `"ca-central-1"`

### <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)

Description: (Optional) The domain name for the public Route 53 hosted zone.

Type: `string`

Default: `"benoit-blais.sbx.hashidemos.io"`

### <a name="input_local_domain_name"></a> [local\_domain\_name](#input\_local\_domain\_name)

Description: (Optional) The domain name for the private local Route 53 hosted zone.

Type: `string`

Default: `"benoit-blais.sbx.hashidemos.local"`

## Resources

The following resources are used by this module:

- [aws_route53_record.acme_challenge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) (resource)
- [aws_route53_record.caa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) (resource)
- [aws_route53_zone.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) (resource)
- [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) (data source)

## Outputs

The following outputs are exported:

### <a name="output_local_name_servers"></a> [local\_name\_servers](#output\_local\_name\_servers)

Description: A list of name servers for the local private hosted zone.

### <a name="output_local_zone_id"></a> [local\_zone\_id](#output\_local\_zone\_id)

Description: The ID of the local private hosted zone.

### <a name="output_local_zone_name"></a> [local\_zone\_name](#output\_local\_zone\_name)

Description: The name of the local private hosted zone.

### <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers)

Description: A list of name servers for the hosted zone.

### <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id)

Description: The ID of the hosted zone.

### <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name)

Description: The name of the public hosted zone.

<!-- markdownlint-enable -->
## External Documentation

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Route 53 Documentation](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)
- [Let's Encrypt CAA Record configuration](https://letsencrypt.org/docs/caa/)
<!-- END_TF_DOCS -->