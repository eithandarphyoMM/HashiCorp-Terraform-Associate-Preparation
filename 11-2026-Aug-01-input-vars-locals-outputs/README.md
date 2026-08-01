### Summary of Terraform Variable Precedence (High to Low Priority)
1. CLI Flags (`-var` and `-var-file`): Highest precedence[cite: 251, 252, 253]. Overrides everything else passed via command line.
2.【DONE】 `*.auto.tfvars` / `*.auto.tfvars.json`: Automatically loaded `.tfvars` files, evaluated in alphabetical order[cite: 245, 252, 253].
3. `terraform.tfvars` / `terraform.tfvars.json`: Standard auto-loaded variable definition files[cite: 245, 252, 253].
4. Environment Variables (`TF_VAR_<name>`): Shell environment variables starting with the prefix `TF_VAR_`.
5. Variable Defaults (`default = ...`): Lowest priority[cite: 251, 252]. Used only when no other value is supplied in `variables.tf`.
