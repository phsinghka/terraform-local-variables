# Terraform Project: Simplifying Configuration with Local Variables

## Introduction

This project demonstrates how to use **local variables** in Terraform to simplify and enhance the maintainability of your infrastructure code. You will create a basic AWS network infrastructure and refactor the code using local variables to reduce repetition and improve readability.

## Prerequisites

- **Terraform** installed on your local machine
- **AWS Account** with access keys configured
  - Configure your AWS credentials using environment variables or AWS config files
- **AWS CLI** (optional, for verification)

## Project Structure

```
├── main.tf
└── README.md
```

## Getting Started

### 1. Clone the Repository

```bash
cd terraform-local-variables
```

### 2. Initialize Terraform

Initialize the Terraform working directory, which will download the AWS provider.

```bash
terraform init
```

### 3. Review the Configuration

Open `main.tf` to review the Terraform configuration, which includes:

- Provider configuration for AWS
- Local variables declaration
- Resources for VPC, Subnets, Internet Gateway, and Route Tables using local variables

### 4. Validate the Configuration

Ensure that the Terraform files are syntactically valid.

```bash
terraform validate
```

### 5. Plan the Deployment

Generate and review the execution plan.

```bash
terraform plan
```

### 6. Apply the Configuration

Apply the Terraform configuration to create the resources.

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### 7. Verify the Deployment

You can verify the created resources via:

- **AWS Management Console**: Navigate to VPC and check the created resources.
- **AWS CLI**: List the VPCs and subnets to confirm their creation.

### 8. Destroy the Resources

After you're done, destroy the resources to prevent any unwanted charges.

```bash
terraform destroy
```
