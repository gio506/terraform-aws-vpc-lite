# terraform-aws-vpc-lite

Beginner-friendly Terraform project to create a **basic AWS network**:
- 1 VPC
- 1 public subnet
- Internet Gateway (IGW)
- Public route table + association
- Security group (SSH + HTTP ingress)

## Project tree

```text
.
├── main.tf                   # Core infrastructure resources and provider config
├── variables.tf              # Input variables with defaults
├── outputs.tf                # Useful IDs returned after apply
├── cheatsheet.md             # Quick reference for commands and file purpose
├── examples/
│   └── tfvars.example        # Example variable values you can copy
└── .github/workflows/
    └── ci.yml                # CI pipeline for fmt/validate/lint/plan
```

## Prerequisites

- Terraform >= 1.5
- AWS credentials (for plan/apply against real AWS)
- Optional: tflint

## Quick start

```bash
terraform init
terraform fmt -check
terraform validate
```

### Plan

```bash
cp examples/tfvars.example terraform.tfvars
terraform plan -out=tfplan
```

### Apply

```bash
terraform apply tfplan
```

### Destroy

```bash
terraform destroy
```

## Inputs you should review first

- `ssh_ingress_cidrs`: defaults to `0.0.0.0/0` for beginner simplicity; lock this down for real use.
- `http_ingress_cidrs`: set to allowed client ranges.
- `vpc_cidr` and `public_subnet_cidr`: avoid overlap with existing networks.

## Safety notes

- Start in a **sandbox/test AWS account** first.
- Restrict CIDRs (especially SSH) before production use.
- Always review `terraform plan` output before `apply`.
- Never commit real secrets (`*.tfvars` with credentials, access keys).
- Prefer IAM roles or short-lived credentials instead of long-lived keys.

## CI pipeline stages

The workflow runs 4 stages:
1. `terraform fmt -check`
2. `terraform validate`
3. `tflint`
4. `terraform plan` (no apply)

### GitHub Actions secrets for plan

Set these repository secrets when you want CI `terraform plan` to run with AWS auth:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

If secrets are missing, the plan step is skipped cleanly.
