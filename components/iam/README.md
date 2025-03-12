# IAM Module

## **Introduction**
The **IAM module** creates and manages **IAM roles, policies, and groups** in AWS.  
It provides a **reusable** way to define and control access permissions for different AWS services.

This module supports:
- **IAM Role creation**
- **IAM Policy definition**
- **IAM Group (optional)**
- **Role-to-Policy attachments**

---

## **Input Variables**
| Name                 | Type     | Description                                  | Default |
|----------------------|----------|----------------------------------------------|---------|
| `project_key`        | `string` | Unique prefix for resource names             | `""`    |
| `role_name`          | `string` | Name of the IAM role                         | `""`    |
| `policy_name`        | `string` | Name of the IAM policy                       | `""`    |
| `policy_json`        | `string` | JSON string defining IAM policy              | `""`    |
| `assume_role_policy` | `string` | JSON string defining assume role policy      | `""`    |
| `create_group`       | `bool`   | Whether to create an IAM group               | `false` |
| `group_name`         | `string` | IAM group name (if `create_group` is `true`) | `""`    |

---

## **Output Variables**
| Name         | Description                 |
|--------------|-----------------------------|
| `role_arn`   | ARN of the IAM Role         |
| `policy_arn` | ARN of the IAM Policy       |
| `group_name` | IAM Group Name (if created) |

---

## **Usage**
```hcl
module "iam" {
  source = "git::https://github.com/your-org/aws-tf-modules.git//modules/iam?ref=v1.0.0"

  project_key        = "myproj"
  role_name          = "app-role"
  policy_name        = "app-policy"

  assume_role_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOT

  policy_json = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::myproj-bucket/*"]
    }
  ]
}
EOT

  create_group = true
  group_name   = "developers"
}
```

---

## **Versioning**
- Always use **tagged releases** when referencing this module:
  ```hcl
  source = "git::https://github.com/your-org/aws-tf-modules.git//modules/iam?ref=v1.0.0"
  ```
- Follow **semantic versioning** (`v1.0.0`, `v1.1.0`, `v2.0.0`, etc.).

---

## **Best Practices**
- **Follow least privilege**: Grant only required permissions.
- **Use managed policies when possible** to reduce maintenance.
- **Restrict Assume Role Policies** to limit exposure.
- **Tag IAM resources** for better cost tracking.
- **Version control IAM policy changes** for auditability.