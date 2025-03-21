# Terraform AWS KMS Module

## 📘 Introduction

This module creates a fully managed [AWS KMS (Key Management Service)](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html) key.  
It supports optional key rotation, custom policies, and tagging.  
Ideal for encrypting resources like S3 buckets, Lambda environment variables, and more.

---

## 📥 Input Variables

| Name                      | Description                                  | Type          | Default                          |
|---------------------------|----------------------------------------------|---------------|----------------------------------|
| `description`             | Description of the KMS key                   | `string`      | `"KMS key managed by Terraform"` |
| `deletion_window_in_days` | Waiting period before deletion (7–30 days)   | `number`      | `30`                             |
| `enable_key_rotation`     | Enables automatic key rotation (recommended) | `bool`        | `true`                           |
| `policy`                  | Optional custom key policy (JSON string)     | `string`      | `null`                           |
| `tags`                    | Key-value tags to apply                      | `map(string)` | `{}`                             |

---

## 📤 Output Variables

| Name     | Description          |
|----------|----------------------|
| `key_id` | ID of the KMS key    |
| `arn`    | ARN of the KMS key   |

---

## 🚀 Usage

### Example 1: Create a basic KMS key with rotation enabled

```hcl
module "kms_basic" {
  source = "git::https://github.com/my-org/terraform-aws-modules.git//kms"

  description         = "Basic KMS key for general encryption"
  enable_key_rotation = true

  tags = {
    Environment = "prod"
    Owner       = "security-team"
  }
}
```

---

### Example 2: Create a KMS key with a custom policy

```hcl
module "kms_custom_policy" {
  source = "git::https://github.com/my-org/terraform-aws-modules.git//kms"

  description = "Custom KMS key for S3 encryption"
  policy      = file("${path.module}/kms-policy.json")

  tags = {
    Project = "data-lake"
  }
}
```

---

### Example 3: Create a temporary KMS key with deletion window set

```hcl
module "kms_temp" {
  source = "git::https://github.com/my-org/terraform-aws-modules.git//kms"

  description             = "Temporary KMS key for testing"
  deletion_window_in_days = 7
  enable_key_rotation     = false
}
```

---

### 📎 Notes:

- `enable_key_rotation` is only applicable to customer-managed symmetric keys.
- If you pass a `policy`, it will override the default Terraform-generated policy.
- Default IAM permissions must still allow KMS usage for the calling service.
- Use `aws_kms_alias` to create friendly names if needed.

---

## ✅ Best Practices

- ✅ Enable **key rotation** for long-term security.
- 🔐 Assign **principle of least privilege** in key policies.
- 🧹 Set `deletion_window_in_days` to 7 during testing, and 30 in production.
- 🏷 Tag your KMS keys for traceability and cost attribution.
- 📄 Consider using `alias` resources to manage keys across environments.

---
