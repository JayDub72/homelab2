# Terraform Configuration

This directory contains Terraform configurations for provisioning VMs and LXC containers on Proxmox.

## Structure

```
terraform/
├── modules/
│   └── proxmox-vm/          # Reusable VM module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    └── homelab/             # Main environment
        ├── main.tf
        ├── providers.tf
        ├── variables.tf
        ├── outputs.tf
        ├── vms.auto.tfvars  # VM definitions
        ├── terraform.tfvars # Private config (not in git)
        └── templates/
            └── inventory.tpl
```

## Prerequisites

1. Terraform >= 1.0
2. Proxmox VE cluster
3. VM template(s) created in Proxmox (cloud-init enabled)

## Initial Setup

1. **Navigate to the environment directory:**
   ```bash
   cd terraform/environments/homelab
   ```

2. **Create your configuration file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit `terraform.tfvars` with your credentials:**
   ```bash
   # Better: Use environment variables
   export TF_VAR_proxmox_api_password="your_password"
   ```

4. **Define your VMs in `vms.auto.tfvars`:**
   - Add/modify VM definitions as needed
   - Each VM is a key-value pair in the `vms` map

5. **Initialize Terraform:**
   ```bash
   terraform init
   ```

## Usage

### Plan Changes
```bash
terraform plan
```

### Apply All VMs
```bash
terraform apply
```

### Target Specific VM
```bash
terraform apply -target=module.vms[\"seed-box\"]
```

### Destroy Specific VM
```bash
terraform destroy -target=module.vms[\"seed-box\"]
```

### Generate Ansible Inventory
```bash
terraform output -raw ansible_inventory > ../../ansible/inventory/hosts
```

## Adding a New VM

Simply add a new entry to `vms.auto.tfvars`:

```hcl
vms = {
  "my-new-vm" = {
    node_name      = "donnager"
    vm_id          = 205
    tags           = ["terraform", "ubuntu", "web"]
    template_id    = 9001
    cpu_cores      = 2
    memory_mb      = 4096
    disk_datastore = "tank"
    disk_size_gb   = 50
    ip_address     = "192.168.10.105/24"
  }
}
```

Then run `terraform apply`.

## Security Notes

- **Never commit `terraform.tfvars`** - it contains credentials
- Use environment variables for sensitive data:
  ```bash
  export TF_VAR_proxmox_api_password="password"
  ```
- Consider using Vault or SOPS for secret management
- Use API tokens instead of passwords when possible

## Outputs

After applying, you can retrieve:
- **VM IP addresses:** `terraform output vm_ip_addresses`
- **All VM details:** `terraform output vm_details`
- **Ansible inventory:** `terraform output -raw ansible_inventory`

## Common Issues

### "VM already exists"
If Terraform tries to create a VM with an ID that already exists, either:
1. Import it: `terraform import 'module.vms[\"vm-name\"].proxmox_virtual_environment_vm.vm' <node>/<vmid>`
2. Change the VM ID in `vms.auto.tfvars`
3. Manually remove the conflicting VM

### "Unable to connect to Proxmox"
- Verify API URL is correct
- Check firewall rules allow access to port 8006
- Ensure credentials are valid

## Best Practices

1. **Use version control** for all `.tf` files and `vms.auto.tfvars`
2. **Keep secrets out** of version control (use `.gitignore`)
3. **Plan before apply** to review changes
4. **Use meaningful VM names** and tags for organization
5. **Document** non-obvious configuration choices in comments
