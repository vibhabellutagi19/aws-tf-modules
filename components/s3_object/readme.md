# Terraform AWS S3 Object Module

## Introduction

This module uploads a file from your local machine to an AWS S3 bucket.  
It supports encryption using a KMS key, content type setting, ACL management, and tagging.

Use this module when you want to automate object uploads during infrastructure provisioning — for example, Lambda deployment packages, config files, or static assets.

---

## Input Variables

| Name         | Description                             | Type         | Default                 |
|--------------|-----------------------------------------|--------------|-------------------------|
| `bucket`     | Name of the S3 bucket                   | `string`     | _n/a_ (required)        |
| `key`        | Path (key) for the uploaded object      | `string`     | _n/a_ (required)        |
| `source`     | Local path to the file to upload        | `string`     | _n/a_ (required)        |
| `content_type` | MIME type of the object              | `string`     | `"binary/octet-stream"` |
| `kms_key_id` | KMS key ID used to encrypt the object   | `string`     | `null`                  |
| `acl`        | Canned ACL to apply                     | `string`     | `"private"`             |
| `tags`       | Tags to associate with the object       | `map(string)`| `{}`                    |

---

## Output Variables

| Name        | Description                        |
|-------------|------------------------------------|
| `object_url`| Public-style URL of the S3 object  |
| `etag`      | ETag (MD5 hash) of the object      |

---

## Usage

### Example 1: Upload a Lambda zip file with default settings

```hcl
module "lambda_zip" {
  source = "git::https://github.com/my-org/terraform-aws-modules.git//s3-object"

  bucket = "my-lambda-artifacts"
  key    = "functions/hello-lambda.zip"
  source = "${path.module}/build/hello-lambda.zip"
}
```

---

### Example 2: Upload a JSON file with content type and KMS encryption

```hcl
module "config_json" {
  source = "git::https://github.com/my-org/terraform-aws-modules.git//s3-object"

  bucket       = "my-config-bucket"
  key          = "configs/app-config.json"
  source       = "${path.module}/app-config.json"
  content_type = "application/json"
  kms_key_id   = aws_kms_key.app_encryption.arn

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

---

### Example 3: Upload a file with public-read access

```hcl
module "public_asset" {
  source = "git::https://github.com/my-org/terraform-aws-modules.git//s3-object"

  bucket = "static-assets"
  key    = "images/logo.png"
  source = "${path.module}/assets/logo.png"
  acl    = "public-read"
}
```

---

### Notes:

- The module computes and includes the ETag to force re-upload if the file changes.
- If `kms_key_id` is specified, the object will be encrypted using server-side KMS encryption.
- You are responsible for ensuring the IAM role has the necessary permissions (e.g., `s3:PutObject`, `kms:Encrypt`).
- Use relative paths for `source` to stay consistent with module structure.

---

## Best Practices

- 🔐 Encrypt sensitive uploads using KMS (`kms_key_id`).
- 🎯 Use precise object keys and structure them logically (e.g., `env/service/component/file.ext`).
- 🏷 Tag uploads for tracking and cost attribution.
- 🪪 Avoid `public-read` unless the object is truly public-facing (e.g., CDN assets).
- ⚙️ Use this module in CI/CD pipelines to deploy Lambda packages, assets, and environment-specific configs.

---