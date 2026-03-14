# Files Explained

- `.github/workflows/ci.yml`: 4-stage CI for fmt, validate, tflint, and plan.
- `.tflint.hcl`: Terraform lint configuration.
- `CHEATSHEET.md`: quick command reference.
- `FILES_EXPLAINED.md`: short purpose statement for every tracked file.
- `README.md`: main project guide and safety notes.
- `examples/tfvars.example`: sample variable values.
- `main.tf`: root module wiring that calls `modules/vpc-lite`.
- `modules/vpc-lite/main.tf`: reusable AWS network resources.
- `modules/vpc-lite/outputs.tf`: module outputs.
- `modules/vpc-lite/variables.tf`: module input definitions.
- `outputs.tf`: root outputs exposed to users.
- `variables.tf`: root input defaults.
- `versions.tf`: Terraform and AWS provider version constraints.
