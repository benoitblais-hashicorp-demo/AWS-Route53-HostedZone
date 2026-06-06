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