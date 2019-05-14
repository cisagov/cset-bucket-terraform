# cset-bucket-terraform 💾 #

[![Build Status](https://travis-ci.com/cisagov/cset-bucket-terraform.svg?branch=develop)](https://travis-ci.com/cisagov/cset-bucket-terraform)

## About ##

This project creates the resources used to host CSET binaries from an S3 bucket.

## Requirements ##

* [AWS CLI access
  configured](
  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
  on your system
* [Terraform installed](
  https://learn.hashicorp.com/terraform/getting-started/install.html)
  on your system

## Customizing Your Environment ##

Create a terraform variables file to be used for your environment (e.g.
  `production.yml`), based on the variables listed in `variables.tf`.
  Here is a sample of what that file might look like:

```yaml
aws_region = "us-east-1"

aws_availability_zone = "a"

tags = {
  Team = "CISA Development Team"
  Application = "CSET Binaries"
  Workspace = "production"
}
```

## Terraform Documentation ##

<!-- markdownlint-disable MD003 MD013 MD022 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable MD003 MD013 MD022 -->

## Building the Terraform-based infrastructure ##

The Terraform-based infrastructure is built like so:

```bash
terraform init

# If you have not created your terraform workspace:
terraform workspace new <your_workspace>

# If you have previously created your terraform workspace:
terraform workspace select <your_workspace>

terraform apply -var-file=<your_workspace>.yml
```

## Tearing down the Terraform-based infrastructure ##

The Terraform-based infrastructure is torn down like so:

```bash
terraform workspace select <your_workspace>
terraform destroy -var-file=<your_workspace>.yml
```

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE.md).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
