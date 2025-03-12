# Lambda Module

## **Introduction**
The **Lambda module** allows you to create an AWS Lambda function along with an **IAM role and optional IAM policies**. It provides a **reusable** way to deploy Lambda functions across multiple AWS environments.

This module supports:
- **Lambda function creation**
- **IAM role for Lambda execution**
- **Custom IAM policy attachment (optional)**
- **Configurable runtime, memory, and environment variables**

---

## **Input Variables**
| Name                     | Type          | Description                                           | Default |
|--------------------------|--------------|------------------------------------------------------|---------|
| `project_key`           | `string`      | Unique prefix for resources                         | `""`    |
| `lambda_name`           | `string`      | Name of the Lambda function                         | `""`    |
| `lambda_source_file`    | `string`      | Path to the Lambda function source file            | `""`    |
| `lambda_runtime`        | `string`      | Runtime environment (e.g., python3.8, nodejs14.x)  | `""`    |
| `lambda_handler`        | `string`      | Lambda handler (e.g., index.handler)               | `""`    |
| `lambda_memory`         | `number`      | Memory size in MB                                  | `128`   |
| `lambda_timeout`        | `number`      | Timeout in seconds                                 | `10`    |
| `lambda_environment_variables` | `map(string)` | Environment variables for Lambda           | `{}`    |
| `attach_custom_policy`  | `bool`        | Attach a custom policy to the IAM role             | `false` |
| `custom_policy_json`    | `string`      | JSON string defining IAM policy                    | `""`    |

---

## **Output Variables**
| Name                  | Description                            |
|----------------------|--------------------------------|
| `lambda_function_name` | Name of the Lambda function   |
| `lambda_function_arn`  | ARN of the Lambda function    |
| `iam_role_arn`        | IAM Role ARN assigned to Lambda |

---

## **Usage**

```terraform
module "lambda" {
  source          = "git::https://github.com/your-org/aws-tf-modules.git//modules/lambda?ref=v1.0.0"

  project_key     = "devproj"
  lambda_name     = "data-processor"
  lambda_source_file = "lambda_function.py"
  lambda_runtime  = "python3.8"
  lambda_handler  = "lambda_function.lambda_handler"
  lambda_memory   = 256
  lambda_timeout  = 15

  lambda_environment_variables = {
    LOG_LEVEL = "DEBUG"
    API_KEY   = "my-api-key"
  }

  attach_custom_policy = true
  custom_policy_json = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::devproj-data/*"]
    }
  ]
}
EOT
}

```

## **Best Practices**
- **Use least privilege IAM permissions** for Lambda.
- **Enable logging** for better debugging.
- **Use environment variables** to avoid hardcoding secrets.
- **Package dependencies properly** if required.
