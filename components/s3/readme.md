## **📌 S3 Bucket Module**

Table of Contents

- [Introduction](#introduction)
- [Input Variables](#input-variables)
- [Output](#outputs)
- [Usage](#usage)
- [Best Practices](#best-practices)

---

## **Introduction**
The **S3 Bucket module** provisions an AWS S3 bucket.

---
## **Input Variables**
| Name                        | Type          | Default | Description                                                                                                      |
|-----------------------------|---------------|---------|------------------------------------------------------------------------------------------------------------------|
| `bucket_name`               | `string`      | `null`  | (Optional) The name of the S3 bucket. If provided, `bucket_prefix` is ignored.                                   |
| `bucket_prefix`             | `string`      | `null`  | (Optional) Prefix for the bucket name. Terraform will generate a unique suffix if `bucket_name` is not provided. |
| `force_destroy`             | `bool`        | `false` | (Optional) If `true`, allows deletion of non-empty buckets.                                                      |
| `custom_bucket_policy_json` | `string`      | `""`    | (Optional) Custom JSON policy for the S3 bucket. If provided, the bucket policy will be attached.                |
| `default_tags`              | `map(string)` | `{}`    | (Optional) Key-value pairs for tagging the S3 bucket.                                                            |

---

## **Outputs**
| Name                | Description                                              |
|---------------------|----------------------------------------------------------|
| `bucket_name`       | The name of the created S3 bucket.                       |
| `bucket_arn`        | The ARN (Amazon Resource Name) of the created S3 bucket. |
| `bucket_policy_arn` | The ARN of the S3 Bucket Policy (if created).            |

---

## **usage**
```hcl
module "s3" {
  source          = "git::https://github.com/your-org/aws-tf-modules.git//modules/s3?ref=v1.0.0"

  project_key     = "devproj"
  bucket_name     = "app-logs"
  force_destroy   = true

  custom_bucket_policy_json = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": "s3:GetObject",
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
## **Best Practices**
- **Use least privilege Bucket permissions** for S3.
- **Enable logging** for better debugging.
- **Enable server-side encryption** to protect data at rest.