# Lambda Module

Table of Contents
=================

   * [Introduction](#introduction)
   * [Input Variables](#input-variables)
   * [Output Variables](#output-variables)
   * [Usage](#usage)
      * [Example 1: Local Zip Deployment](#-example-1-local-zip-deployment)
      * [Example 2: S3-Based Deployment](#-example-2-s3-based-deployment)
      * [Example 3: Container Image Lambda](#-example-3-container-image-lambda)
      * [Notes:](#notes)
   * [Best Practices](#best-practices)

## **Introduction**
The **Lambda module** allows you to create an AWS Lambda function along with an **IAM role and optional IAM policies**. It provides a **reusable** way to deploy Lambda functions across multiple AWS environments.

This module supports:
- **Lambda function creation**
- **IAM role for Lambda execution**
- **Custom IAM policy attachment (optional)**
- **Configurable runtime, memory, and environment variables**

---

## **Input Variables**
| Name                           | Type          | Description                                       | Default |
|--------------------------------|---------------|---------------------------------------------------|---------|
| `project_key`                  | `string`      | Unique prefix for resources                       | `""`    |
| `lambda_name`                  | `string`      | Name of the Lambda function                       | `""`    |
| `lambda_source_file`           | `string`      | Path to the Lambda function source file           | `""`    |
| `lambda_runtime`               | `string`      | Runtime environment (e.g., python3.8, nodejs14.x) | `""`    |
| `lambda_handler`               | `string`      | Lambda handler (e.g., index.handler)              | `""`    |
| `lambda_memory`                | `number`      | Memory size in MB                                 | `128`   |
| `lambda_timeout`               | `number`      | Timeout in seconds                                | `10`    |
| `lambda_environment_variables` | `map(string)` | Environment variables for Lambda                  | `{}`    |
| `attach_custom_policy`         | `bool`        | Attach a custom policy to the IAM role            | `false` |
| `custom_policy_json`           | `string`      | JSON string defining IAM policy                   | `""`    |

---

## **Output Variables**
| Name                   | Description                     |
|------------------------|---------------------------------|
| `lambda_function_name` | Name of the Lambda function     |
| `lambda_function_arn`  | ARN of the Lambda function      |
| `iam_role_arn`         | IAM Role ARN assigned to Lambda |

---

## **Usage**

- 🗂 **Local zip file deployment**
- 🪣 **S3-based deployment**
- 🐳 **Container image-based Lambda**

---

### ✅ Example 1: **Local Zip Deployment**
This zips a local Python file and deploys it as a Lambda:

```hcl
module "my_lambda" {
  source = "git::https://github.com/my-org/terraform-aws-lambda-module.git"

  project_key           = "myproject"
  lambda_name           = "hello-lambda"
  handler               = "lambda_function.lambda_handler"
  runtime               = "python3.9"
  memory                = 256
  timeout               = 10

  lambda_source_file    = "${path.module}/lambda_function.py"
  lambda_object_path    = "${path.module}/lambda_function.zip"

  environment_variables = {
    ENV = "prod"
  }

  default_tags = {
    Team = "Data"
  }
}
```

---

### ✅ Example 2: **S3-Based Deployment**
This assumes the `.zip` is already uploaded to S3:

```hcl
module "my_lambda_s3" {
  source = "git::https://github.com/my-org/terraform-aws-lambda-module.git"

  project_key        = "myproject"
  lambda_name        = "s3-lambda"
  handler            = "lambda_function.lambda_handler"
  runtime            = "python3.9"
  memory             = 128
  timeout            = 5

  s3_bucket          = "my-lambda-artifacts"
  s3_key             = "lambdas/hello.zip"
  s3_object_version  = "Pp9hJ6BaNQo.klsnA3m4ZpWgC7"

  environment_variables = {
    ENV = "dev"
  }

  default_tags = {
    Owner = "BackendTeam"
  }
}
```

---

### ✅ Example 3: **Container Image Lambda**
For Docker-based Lambda deployment (no handler/runtime needed):

```hcl
module "container_lambda" {
  source = "git::https://github.com/my-org/terraform-aws-lambda-module.git"

  project_key  = "myproject"
  lambda_name  = "container-lambda"
  image_uri    = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-lambda:latest"
  memory       = 512
  timeout      = 15

  environment_variables = {
    MODE = "container"
  }

  default_tags = {
    Service = "image-lambda"
  }
}
```

---

### 🧠 Notes:
- The user doesn't need to set `filename` or `source_code_hash`. Your module logic handles that.
- If `s3_bucket` is passed, it **overrides local zip logic**.
- If `image_uri` is passed, it **overrides both** zip and S3 logic.
- Optional `vpc_config` and `logging_config` can be passed like this:

```hcl
vpc_config = {
  subnet_ids         = ["subnet-xxxx", "subnet-yyyy"]
  security_group_ids = ["sg-xxxx"]
}

logging_config = {
  log_format = "JSON"
  log_group = "/aws/lambda/hello-lambda"
}
```
---

## **Best Practices**
- **Use least privilege IAM permissions** for Lambda.
- **Enable logging** for better debugging.
- **Use environment variables** to avoid hardcoding secrets.
- **Package dependencies properly** if required.
