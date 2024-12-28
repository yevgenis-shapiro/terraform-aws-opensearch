data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "random_password" "master_password" {
  count       = var.custom_master_password_enabled ? 0 : 1
  length      = 10
  special     = true
  min_numeric = 1
  min_special = 1
  min_upper   = 1
}

data "aws_iam_policy_document" "access_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["es:*"]
    resources = ["arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"]
  }
}


resource "aws_opensearch_domain" "os_domain_configuration" {
  count            = var.opensearch_enabled ? 1 : 0
  domain_name      = var.domain_name
  engine_version   = "OpenSearch_${var.engine_version}"
  access_policies  = data.aws_iam_policy_document.access_policy.json
  advanced_options = var.advanced_options == null ? {} : var.advanced_options
  dynamic "advanced_security_options" {
    for_each = var.advanced_security_options
    content {
      enabled                        = var.advanced_security_options_enabled
      internal_user_database_enabled = try(advanced_security_options.value.internal_user_database_enabled, true)

      master_user_options {
        master_user_name     = try(advanced_security_options.master_user_options.value.master_user_name, "admin")
        master_user_password = var.custom_master_password_enabled ? var.custom_master_password : random_password.master_password[0].result
      }
    }
  }

  # cluster_config
  dynamic "cluster_config" {
    for_each = var.cluster_config
    content {
      instance_type            = try(cluster_config.value.instance_type, "t3.medium.search")
      instance_count           = try(cluster_config.value.instance_count, 1)
      dedicated_master_enabled = try(cluster_config.value.dedicated_master_enabled, false)
      dedicated_master_type    = try(cluster_config.value.dedicated_master_type, "r6g.large.search")
      dedicated_master_count   = try(cluster_config.value.dedicated_master_count, 3)
      warm_enabled             = try(cluster_config.value.warm_enabled, false)
      warm_count               = try(cluster_config.value.warm_count, 3)
      warm_type                = try(cluster_config.value.warm_type, "ultrawarm1.medium.search")
      zone_awareness_enabled   = try(cluster_config.value.zone_awareness_enabled, false)
      dynamic "zone_awareness_config" {
        # cluster_availability_zone_count valid values: 2 or 3.
        for_each = lookup(cluster_config.value, "zone_awareness_enabled", false) ? [1] : []
        content {
          availability_zone_count = lookup(cluster_config.value, "availability_zone_count")
        }
      }
    }
  }

  # domain_endpoint_options
  dynamic "domain_endpoint_options" {
    for_each = var.domain_endpoint_options
    content {
      enforce_https                   = try(domain_endpoint_options.value.enforce_https, false)
      tls_security_policy             = "Policy-Min-TLS-1-2-2019-07"
      custom_endpoint_enabled         = try(domain_endpoint_options.value.custom_endpoint_enabled, false)
      custom_endpoint                 = try(domain_endpoint_options.value.custom_endpoint, null)
      custom_endpoint_certificate_arn = try(domain_endpoint_options.value.custom_endpoint_certificate_arn, null)
    }
  }

  # ebs_options
  dynamic "ebs_options" {
    for_each = var.ebs_options
    content {
      ebs_enabled = var.ebs_enabled
      volume_type = try(ebs_options.value.volume_type, "gp2")
      volume_size = try(ebs_options.value.volume_size, 10)
      iops        = try(ebs_options.value.iops, 3000)
    }
  }

  # encrypt_at_rest
  dynamic "encrypt_at_rest" {
    for_each = var.encrypt_at_rest
    content {
      enabled    = try(encrypt_at_rest.value.enabled, false)
      kms_key_id = try(encrypt_at_rest.value.kms_key_id, null)
    }
  }

  # node_to_node_encryption
  dynamic "node_to_node_encryption" {
    for_each = var.node_to_node_encryption
    content {
      enabled = try(node_to_node_encryption.value.enabled, false)
    }
  }

  # snapshot_options
  dynamic "snapshot_options" {
    for_each = var.snapshot_options
    content {
      automated_snapshot_start_hour = try(snapshot_options.value.automated_snapshot_start_hour, 23)
    }
  }

  # log_publishing_options
  dynamic "log_publishing_options" {
    for_each = { for k, v in var.log_publishing_options :
      k => v if var.opensearch_enabled && var.cloudwatch_log_enabled && lookup(v, "enabled", false)
    }
    content {
      log_type                 = upper(log_publishing_options.key)
      cloudwatch_log_group_arn = lookup(log_publishing_options.value, "cloudwatch_log_group_arn", null) != null ? lookup(log_publishing_options.value, "cloudwatch_log_group_arn") : aws_cloudwatch_log_group.es_cloudwatch_log_group[log_publishing_options.key].arn
      enabled                  = lookup(log_publishing_options.value, "enabled")
    }
  }

  # cognito_options
  dynamic "cognito_options" {
    for_each = var.cognito_options
    content {
      enabled          = try(cognito_options.value.enabled, false)
      user_pool_id     = try(cognito_options.value.user_pool_id, null)
      identity_pool_id = try(cognito_options.value.identity_pool_id, null)
      role_arn         = try(cognito_options.value.role_arn, null)
    }
  }
}
