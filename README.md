# aws-tf-modules
This repository contains reusable **Terraform modules** for AWS services. Each module is designed to be configurable and reusable across multiple projects.

---

### **📋 Available Modules**
| Module Name      | Status | Description                                                                                | Inputs | Outputs | Source                 |
|------------------|--------|--------------------------------------------------------------------------------------------|--------|---------|------------------------|
| **S3 Bucket**    | ✅      | Creates an S3 bucket with optional KMS encryption and force deletion.                      | ✅      | ✅       | `modules/s3-bucket`    |
| **EC2 Instance** | ⏳🔜    | Provisions an EC2 instance with configurable instance type, key pair, and security groups. | ✅      | ✅       | `modules/ec2-instance` |
| **VPC**          | ⏳🔜    | Creates a VPC with subnets, NAT gateway, and route tables.                                 | ✅      | ✅       | `modules/vpc`          |
| **IAM Role**     | ⏳🔜    | Creates an IAM role with configurable policies and permissions.                            | ✅      | ✅       | `modules/iam-role`     |
| **Lambda**       | ⏳🔜    | Deploys a Lambda function with IAM permissions and environment variables.                  | ✅      | ✅       | `modules/lambda`       |
| **SQS Queue**    | ⏳🔜    | Creates an SQS queue with optional dead-letter queue (DLQ).                                | ✅      | ✅       | `modules/sqs`          |

---

### **📖 General Usage Guide**
1. **Clone this repo**:
   ```sh
   git clone https://github.com/your-org/aws-tf-modules.git
   ```
2. **Refer modules using `source` in your Terraform project**.
3. **Run Terraform commands**:
   ```sh
   terraform init
   terraform apply
   ```

---

### **📌 Best Practices**
✅ Use **versioning** (`?ref=v1.0.0`) when using modules from GitHub.  
✅ Follow **naming conventions** to keep resources organized.

---