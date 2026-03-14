# Terraform VPC Lite Cheatsheet

## What each file is for
- `main.tf` -> Configures the AWS provider and calls the `modules/vpc-lite` module.
- `variables.tf` -> Root input variables and defaults.
- `outputs.tf` -> Exposes important IDs after apply.
- `versions.tf` -> Terraform and provider version constraints.
- `modules/vpc-lite/*` -> Reusable VPC, subnet, route table, IGW, and security group resources.
- `examples/tfvars.example` -> Sample values for a local `terraform.tfvars`.
- `.tflint.hcl` -> Linter configuration for Terraform and AWS rules.
- `.github/workflows/ci.yml` -> CI checks for fmt, validate, tflint, and plan.

## Core Terraform commands
```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy
```

## Useful day-to-day commands
```bash
terraform plan -refresh=false
terraform show tfplan
terraform output
terraform state list
tflint --init
tflint
```

## Typical local workflow
```bash
cp examples/tfvars.example terraform.tfvars
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
```
