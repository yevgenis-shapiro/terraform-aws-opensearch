## OpenSearch - Search, Visualize, and Analyze 🚀🚀🚀

![images](https://github.com/user-attachments/assets/4d3c26b3-ba31-44ca-8759-ed728031de46)

### Terraform  | AWS
OpenSearch is a enterprise-grade search and observability suite that brings order to unstructured data at scale


```
✅ Machine Learning and AI  (  Vector Database & Anomaly Detection )
✅ Search  ( E-Commerce & Document Search )
✅ Observability ( Performance Monitoring & Log Analysis ) 
✅ Security Analytics ( Threat Intelligence and Event Correlation )

```

🎯 Provisioning

How to launch : Will be soon ...


🔨 Example : Config 

## AWS
```
locals {
  region                         = ""
  custom_master_password         = "$2a$10$lgcvwdvggWeLl1AN14NWsePcWQczWHRQH2eiUNL9w/gN6NaelDl.G"
  custom_master_password_enabled = true
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Dev"
  }
}

module "aws_opensearch" {
  source         = "yevgenis-shapiro/opensearch/aws"
  version        = "1.0.1"
  opensearch_enabled = true
  domain_name    = "skaf"
  engine_version = "2.7"
  cluster_config = [{
    instance_type            = "t3.medium.search"
    instance_count           = 1
#warm nodes depends on dedicated master type nodes. 
    dedicated_master_enabled = false
    dedicated_master_type    = "r6g.large.search"
    dedicated_master_count   = 3
    warm_enabled             = false
    zone_awareness_enabled   = false
    availability_zone_count  = 1
  }]

  custom_master_password_enabled    = local.custom_master_password_enabled
  custom_master_password            = local.custom_master_password
  advanced_security_options_enabled = true
  advanced_security_options = [{
    master_user_options = {
      master_user_name     = "admin"
      master_user_password = local.custom_master_password_enabled ? local.custom_master_password : ""
    }
  }]

  domain_endpoint_options = [{
    enforce_https            = true
    custom_endpoint_enabled  = false
  }]

  ebs_enabled = true
  ebs_options = [{
    volume_size = 10
    volume_type = "gp2"
    iops        = 3000
  }]

  #if you will not pass kms_key_id it will pick default key
  encrypt_at_rest = [{
    enabled = true
    #kms_key_id = "arn:aws:kms:us-east-2:271251951598:key/f1e2f1a9-686a-4e31-sfffseerre"
  }]

  cloudwatch_log_enabled = false
  log_publishing_options = {
    es_application_logs = {
      enabled                          = true
      log_publishing_options_retention = 30
      cloudwatch_log_group_name        = "os_application_logs_dev"
    }
    audit_logs = {
      enabled                          = false
      log_publishing_options_retention = 30
      cloudwatch_log_group_name        = "os_audit_logs"
    }
  }

  node_to_node_encryption = [
    {
      enabled = true
    }
  ]

  snapshot_options = [{
    automated_snapshot_start_hour = 23
  }]
}
```
## Google
```

```
