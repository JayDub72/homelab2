output "vm_details" {
  description = "Details of all created VMs"
  value = {
    for vm_name, vm in module.vms : vm_name => {
      id          = vm.vm_id
      name        = vm.vm_name
      ip_address  = vm.ipv4_address
      mac_address = vm.mac_address
    }
  }
}

output "vm_ip_addresses" {
  description = "Map of VM names to IP addresses"
  value = {
    for vm_name, vm in module.vms : vm_name => vm.ipv4_address
  }
}

# Generate Ansible inventory
output "ansible_inventory" {
  description = "Ansible inventory in INI format"
  value = templatefile("${path.module}/templates/inventory.tpl", {
    vms = {
      for vm_name, vm in module.vms : vm_name => {
        ip = vm.ipv4_address
        tags = var.vms[vm_name].tags
      }
    }
  })
}
