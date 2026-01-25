output "vm_id" {
  description = "VM ID"
  value       = proxmox_virtual_environment_vm.vm.id
}

output "vm_name" {
  description = "VM name"
  value       = proxmox_virtual_environment_vm.vm.name
}

output "ipv4_address" {
  description = "Primary IPv4 address"
  value       = try(proxmox_virtual_environment_vm.vm.ipv4_addresses[1][0], null)
}

output "ipv4_addresses" {
  description = "All IPv4 addresses"
  value       = proxmox_virtual_environment_vm.vm.ipv4_addresses
}

output "mac_address" {
  description = "MAC address"
  value       = try(proxmox_virtual_environment_vm.vm.mac_addresses[0], null)
}

