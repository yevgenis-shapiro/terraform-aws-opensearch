## terraform-kubernetes-opensearch Example

![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
This example will be very useful for users who are new to a module and want to quickly learn how to use it. By reviewing the examples, users can gain a better understanding of how the module works, what features it supports, and how to customize it to their specific needs.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_es"></a> [aws\_es](#module\_aws\_es) | squareops/opensearch/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the domain |
| <a name="output_dashboard_endpoint"></a> [dashboard\_endpoint](#output\_dashboard\_endpoint) | Domain-specific endpoint for kibana without https scheme |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Unique identifier for the domain |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_master_password"></a> [master\_password](#output\_master\_password) | Master password |
| <a name="output_master_username"></a> [master\_username](#output\_master\_username) | Master username |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
