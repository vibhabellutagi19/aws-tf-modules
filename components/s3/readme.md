## **📌 S3 Bucket Module**
This Terraform module provisions an **AWS S3 bucket** with optional KMS encryption, force deletion, and prefix-based naming.

---

### **📥 Input Variables**
| Name                        | Type          | Default | Description                                                                                                      |
|-----------------------------|---------------|---------|------------------------------------------------------------------------------------------------------------------|
| `bucket_name`               | `string`      | `null`  | (Optional) The name of the S3 bucket. If provided, `bucket_prefix` is ignored.                                   |
| `bucket_prefix`             | `string`      | `null`  | (Optional) Prefix for the bucket name. Terraform will generate a unique suffix if `bucket_name` is not provided. |
| `force_destroy`             | `bool`        | `false` | (Optional) If `true`, allows deletion of non-empty buckets.                                                      |
| `sse_kms_encrypted_objects` | `bool`        | `false` | (Optional) If `true`, enables server-side encryption using AWS KMS.                                              |
| `tags`                      | `map(string)` | `{}`    | (Optional) Key-value pairs for tagging the S3 bucket.                                                            |

---

### **📤 Outputs**
| Name          | Description                                              |
|---------------|----------------------------------------------------------|
| `bucket_name` | The name of the created S3 bucket.                       |
| `bucket_arn`  | The ARN (Amazon Resource Name) of the created S3 bucket. |

---

### **🚀 Usage**
```hcl
module "s3" {
  source          = "git::https://github.com/your-org/aws-tf-modules.git//modules/s3?ref=v1.0.0"
  
  project_key     = "devproj"
  bucket_name     = "app-logs"
  iam_role_name   = "s3-access-role"
  policy_name     = "s3-access-policy"

  custom_policy_json = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": ["arn:aws:s3:::devproj-app-logs/*"]
    }
  ]
}
EOT

  default_tags = {
    Environment = "dev"
    Owner       = "user@example.com"
  }
}
```

---



## **Versioning**
- Always use **tagged releases** when referencing this module:
  ```hcl
  source = "git::https://github.com/your-org/aws-tf-modules.git//modules/s3?ref=v1.0.0"
  ```
- Follow **semantic versioning** (`v1.0.0`, `v1.1.0`, `v2.0.0`, etc.).

---

## **Best Practices**
- **Enable S3 versioning** to protect against accidental deletions.
- **Use lifecycle policies** to automatically delete/archive objects.
- **Enforce encryption** (SSE-S3 or SSE-KMS) for data security.
- **Restrict public access** using S3 bucket policies.
- **Use IAM policies instead of bucket policies** where possible.
- **Apply tags** to help track ownership and cost allocation.
```


### **📖 Notes**
- If **`bucket_name` is provided**, `bucket_prefix` is ignored.
- To ensure security, **KMS encryption** is enabled only when `sse_kms_encrypted_objects = true`.
- Set `force_destroy = true` carefully, as it will delete even non-empty buckets.