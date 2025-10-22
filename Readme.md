## 🛡️ AWS Vulnerable-to-Secure Architecture with Terraform

### Overview

This project provisions two contrasting AWS environments using Terraform: one intentionally vulnerable, and one hardened for production. It demonstrates security best practices, lifecycle control, and modular infrastructure design. The goal is to teach, compare, and showcase secure cloud architecture for recruiter and academic impact.

---

### 🎯 Purpose

- **Vulnerable Setup**: Highlights insecure defaults (e.g., open security groups, public EC2, no WAF)
- **Secure Setup**: Implements layered defenses (WAF, Bastion, locked-down SGs, VPC endpoints)

---

## 🖼️ Architecture Diagrams

- `diagram-vulnerable`
  
  ![alt text](Diagrams/Aws-vulnerable.png)

- `diagram-secure`
  
  ![alt text](Diagrams/Aws-secure.png)
  
---

## 📁 Folder Structure

```
aws-vulnerable-to-secure-architecture/
├── README.md                     # Unified documentation
├── .gitignore                    # Excludes .pem, .tfstate, etc.
├── LICENSE.pem                  
│
├── pre-requisites/               # Setup guides for CLI tools
│   └── Readme.md
│
├── state-bucket/                 # Remote backend (S3)
│   └── main.tf
│
├── vulnerable-architecture/      # Insecure AWS setup
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   ├── backend.tf
│   └── modules/
│       ├── vpc/
│       ├── ec2/
│       ├── rds/
│       ├── alb/
│       └── s3/
│
├── secure-architecture/          # Secure AWS setup
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   ├── backend.tf
│   └── modules/
│       ├── vpc/
│       ├── ec2/
│       ├── rds/
│       ├── alb/
│       ├── waf/
│       ├── bastion/
│       ├── nat/
│       ├── s3/
│       └── s3_endpoints/
│
└── Diagrams/
    ├── Aws-Vulnerable.png
    └── Aws-Secure.png


```
---

## ✅ Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform ≥ 1.3.0
- EC2 key pair created and `.pem` excluded via `.gitignore`
- IAM role for EC2 with S3 access (optional)
- S3 bucket created for secure setup (`secure-app-data-bucket`)

See `prerequisites/` for setup guides.

---

## 🔐 Secure Architecture

- EC2 and RDS in private subnets
- Bastion host for SSH access
- WAF-protected ALB
- NAT Gateway for outbound traffic
- VPC endpoint for private S3 access
- IAM roles and bucket policies enforced

---

## 🔧 Vulnerable Architecture

- Public EC2 and RDS instances
- Open security groups (`0.0.0.0/0`)
- No NAT Gateway or Bastion
- No WAF or VPC endpoints
- S3 bucket publicly accessible (if used)

---

## 🚀 Deployment Sequence

### Vulnerable Setup

```bash
cd vulnerable-architecture
terraform init
terraform apply -auto-approve
```

### Secure Setup

```bash
cd secure-architecture
terraform init
terraform apply -auto-approve
```

---

## 🔥 Teardown Sequence

```bash
cd secure-architecture
terraform destroy -auto-approve

cd ../vulnerable-architecture
terraform destroy -auto-approve
```

---

## 🧠 Key Differences between two setups 

| Component        | Vulnerable Setup                  | Secure Setup                          |
|------------------|-----------------------------------|----------------------------------------|
| EC2              | Public, open SG                   | Private, Bastion access only           |
| RDS              | Public, weak SG                   | Private, locked-down SG                |
| ALB              | None                              | WAF-protected ALB                      |
| S3               | Public bucket                     | Private bucket via VPC endpoint        |
| SSH              | Direct from internet              | Via Bastion only                       |
| IAM              | None                              | Role-based access for EC2              |
| Lifecycle        | No teardown logic                 | Full teardown and validation scripts   |

---

## 🧩 Common Errors & Fixes

- ❌ `aws_vpc_endpoint.s3.dns_entry[0]`  
  **Fix**: Gateway endpoints don’t return DNS entries—remove that output.

- ❌ `Reference to undeclared resource`  
  **Fix**: Ensure route tables are declared in correct modules (e.g., NAT, not VPC).

- ❌ `Missing required variables`  
  **Fix**: Use `terraform.tfvars` to centralize inputs and avoid prompts.

---

## 🔧 What Could Be Improved

Add CI/CD pipeline to validate both setups on commit

Add tagging standards and cost allocation labels

Integrate AWS Config and Security Hub for continuous compliance

Simulate real-world threats using IAM Access Analyzer

---
