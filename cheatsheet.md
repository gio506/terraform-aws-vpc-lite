# Terraform VPC Lite Cheatsheet

## What each file is for
- `main.tf` -> Defines AWS provider and all network resources (VPC, subnet, IGW, route table, SG).
- `variables.tf` -> All configurable inputs and defaults.
- `outputs.tf` -> Exposes important IDs after apply.
- `examples/tfvars.example` -> Sample values for a local `terraform.tfvars`.
- `.tflint.hcl` -> Linter configuration for Terraform and AWS rules.
- `.github/workflows/ci.yml` -> CI checks (fmt, validate, lint, plan simulation/real plan).

## Core Terraform commands (what they do)
```bash
terraform init                     # Download providers and initialize working directory
terraform fmt -check -recursive    # Enforce Terraform formatting
terraform validate                 # Validate syntax and internal config consistency
terraform plan -out=tfplan         # Generate execution plan and save to file
terraform apply tfplan             # Apply exactly the saved plan
terraform destroy                  # Remove all managed resources
```

## Useful day-to-day commands
```bash
terraform plan                     # Quick preview without saving a plan file
terraform plan -refresh=false      # Simulation-style plan without refreshing remote state
terraform show tfplan              # Read a saved plan in human-readable format
terraform output                   # Print outputs after apply
terraform output -json             # Machine-readable outputs (for scripts/CI)
terraform state list               # List resources in current Terraform state
terraform providers                # Show required providers and dependency graph info
```

## Typical local workflow
```bash
cp examples/tfvars.example terraform.tfvars
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

## Lint commands
```bash
tflint --init                      # Install/update required tflint plugins
tflint                             # Run Terraform lint checks
```

## CI simulation behavior
- If AWS secrets are present in CI, pipeline runs real no-apply plan (`terraform plan -out=tfplan`).
- If AWS secrets are missing, pipeline runs simulation-style plan (`terraform plan -refresh=false`).

## Security quick tips
- Replace `ssh_ingress_cidrs` with office/VPN IPs.
- Keep credentials outside Terraform files.
- Use least-privilege IAM permissions.
- Never commit real `terraform.tfvars` containing secrets.
