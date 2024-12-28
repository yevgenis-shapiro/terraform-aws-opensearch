variable "opensearch_enabled" {
  description = "Set to false to prevent the deployment of any AWS OpenSearch resources."
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "Name of the OpenSearch domain used for deploying the OpenSearch dashboard."
  type        = string
}

variable "engine_version" {
  description = "The version of OpenSearch to deploy."
  type        = string
  default     = "2.7"
}

variable "cloudwatch_log_enabled" {
  description = "Set to false to prevent the deployment of CloudWatch Logs resources."
  type        = bool
  default     = true
}

variable "custom_master_password_enabled" {
  description = "Enable or disable custom master password option."
  type        = bool
  default     = false
}

variable "custom_master_password" {
  description = "Specify the custom master password value."
  type        = string
  default     = ""
}

variable "cluster_config" {
  description = "Configuration options for the OpenSearch cluster, such as instance type, instance count, dedicated master, and availability zones."
  type        = list(any)
  default     = []
}

variable "advanced_security_options" {
  description = "Enable or disable fine-grained access control options."
  type        = list(any)
  default     = []
}

variable "advanced_security_options_enabled" {
  description = "Options for fine-grained access control."
  type        = bool
  default     = true
}

variable "domain_endpoint_options" {
  description = "HTTP(S) related options for the OpenSearch domain endpoint."
  type        = list(any)
  default     = []
}

variable "ebs_options" {
  description = "Enable or disable the use of EBS volumes for OpenSearch instances."
  type        = list(any)
  default     = []
}

variable "ebs_enabled" {
  description = "EBS related options, which may be required based on the chosen instance size."
  type        = bool
  default     = true
}

variable "encrypt_at_rest" {
  description = "Options for encrypting data at rest. Only available for certain instance types."
  type        = list(any)
  default     = []
}

variable "node_to_node_encryption" {
  description = "Node-to-node encryption options for OpenSearch."
  type        = list(any)
  default     = []
}

variable "snapshot_options" {
  description = "Snapshot related options for OpenSearch"
  type        = list(any)
  default     = []
}

variable "cognito_options" {
  description = "Options for Amazon Cognito Authentication for OpenSearch."
  type        = list(any)
  default     = []
}

# log_publishing_options
variable "log_publishing_options" {
  description = "Options for publishing OpenSearch logs to CloudWatch Logs."
  type        = any
  default     = {}
}

variable "log_publishing_options_retention" {
  description = "Retention in days for the created CloudWatch log group for OpenSearch logs."
  type        = number
  default     = 60
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options for OpenSearch. Note that values must be strings wrapped in quotes."
  type        = map(string)
  default     = {}
}
