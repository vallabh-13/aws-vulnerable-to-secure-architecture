# Pre-Requisites Setup

This folder contains essential setup instructions for tools required before deploying the AWS vulnerable-to-secure architecture using Terraform. Each guide ensures your local environment is ready for infrastructure provisioning, containerization, and cloud interaction.

---

## 🔧 Setup Guides

- **aws-cli-login.md**  
  Explains how to configure the AWS CLI with your credentials and default region. Includes steps for access key setup or SSO, and validation using `aws sts get-caller-identity`.

- **docker-install.md**  
  Provides instructions to install Docker on your system. Covers Docker Desktop for Windows/macOS and CLI setup for Linux. Includes validation steps and optional group permissions.

- **terraform-setup.md**  
  Walks through installing the Terraform CLI, verifying the installation, and initializing your project with `terraform init`. Ensures you're ready to deploy infrastructure as code.

---

## 🔐 AWS CLI Login

- Configure access keys or use SSO
- Set default region (`us-east-2`)
- Validate with `aws sts get-caller-identity`

---

## 🐳 Docker Installation

- Install Docker Desktop or CLI
- Validate with `docker version`
- Optional: Add user to `docker` group (Linux)

---

## ⚙️ Terraform Setup

- Install Terraform CLI (v1.5+ recommended)
- Validate with `terraform version`
- Initialize project with `terraform init`

---

## 🧠 Notes

- These steps are **one-time setup** tasks
- `.pem` keys and sensitive files are excluded via `.gitignore`
- All modules assume these tools are installed and configured

---

