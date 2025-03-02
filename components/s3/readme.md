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
  source      = "git::https://github.com/your-org/aws-tf-modules.git//modules/s3-bucket"

  bucket_name                = "my-project-bucket"
  bucket_prefix              = null       # If using generated names
  force_destroy              = true       # Allows bucket deletion
  sse_kms_encrypted_objects  = true       # Enables KMS encryption

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
```

---

### **📖 Notes**
- If **`bucket_name` is provided**, `bucket_prefix` is ignored.
- To ensure security, **KMS encryption** is enabled only when `sse_kms_encrypted_objects = true`.
- Set `force_destroy = true` carefully, as it will delete even non-empty buckets.