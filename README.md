# action-tfprovider-linting
GH action for linting Terraform Providers

## Inputs

### providerName

**Required** terraform provider name (should usually be othe form `terraform-provider-xxxxx`)

### lintTask

**Required** Linting task to perform. (e.g. `lint`, `tflint`, `website-lint`)

### goVersion

**Optional** Version of Go to run against (Defaults to latest `1.13.x`)
~> **NOTE:** alpha stage with this action - *only* 1.13.x (latest) is supported

## Outputs
_None currently_

## Currently Supported providers

* [AzureRM](https://github.com/terraform-providers/terraform-provider-azurerm/)
* [AzureAD](https://github.com/terraform-providers/terraform-provider-azuread/)
