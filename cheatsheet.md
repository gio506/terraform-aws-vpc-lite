# Terraform VPC Lite Cheatsheet

## What each file is for
- `main.tf` -> Defines AWS provider and all network resources (VPC, subnet, IGW, route table, SG).
- `variables.tf` -> All configurable inputs and defaults.
- `outputs.tf` -> Exposes important IDs after apply.
- `examples/tfvars.example` -> Sample values for a local `terraform.tfvars`.
- `.github/workflows/ci.yml` -> CI checks: format, validate, lint, and plan.

## Core commands
```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy
```

## Handy workflow
```bash
cp examples/tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
```

## Notes
- Keep credentials outside Terraform files.
- Use least-privilege IAM permissions.
- Tighten security group ingress for real environments.
