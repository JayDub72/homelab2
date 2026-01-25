# Build Ansible inventory from VMs
locals {
  ansible_inventory_content = yamlencode({
    all = {
      children = {
        for tag, vms in local.vms_by_tag : tag => {
          hosts = {
            for vm_name, vm in vms : vm_name => {
              ansible_host = vm.ip_address
            }
          }
        }
      }
    }
  })

  # Group VMs by their tags
  vms_by_tag = {
    for tag in distinct(flatten([for vm in var.vms : vm.tags])) : tag => {
      for vm_name, vm in module.vms : vm_name => {
        ip_address = vm.ipv4_address
      } if contains(var.vms[vm_name].tags, tag)
    }
  }
}

# Define all your VMs using the module
module "vms" {
  source   = "../../modules/proxmox-vm"
  for_each = var.vms

  name               = each.key
  node_name          = each.value.node_name
  vm_id              = each.value.vm_id
  tags               = each.value.tags
  template_id        = each.value.template_id
  cpu_cores          = each.value.cpu_cores
  cpu_sockets        = lookup(each.value, "cpu_sockets", 1)
  memory_mb          = each.value.memory_mb
  disk_datastore     = each.value.disk_datastore
  disk_size_gb       = each.value.disk_size_gb
  disk_interface     = lookup(each.value, "disk_interface", "scsi0")
  disk_iothread      = lookup(each.value, "disk_iothread", true)
  disk_discard       = lookup(each.value, "disk_discard", "on")
  network_bridge     = lookup(each.value, "network_bridge", var.default_network_bridge)
  network_vlan_id    = lookup(each.value, "network_vlan_id", null)
  ip_address         = lookup(each.value, "ip_address", "dhcp")
  ip_gateway         = lookup(each.value, "ip_address", "dhcp") == "dhcp" ? null : lookup(each.value, "ip_gateway", var.default_gateway)
  agent_enabled      = lookup(each.value, "agent_enabled", true)
  
  user_account_username = var.vm_user_account_username
  user_account_ssh_keys = var.vm_user_account_ssh_keys
  
  # Ansible provisioning
  ansible_playbook_enabled = lookup(each.value, "ansible_enabled", var.default_ansible_enabled)
  ansible_playbook_path    = var.ansible_playbook_path
  ansible_playbook_file    = lookup(each.value, "ansible_playbook", var.default_ansible_playbook)
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content  = local.ansible_inventory_content
  filename = "${path.module}/../../ansible/inventory/hosts"
}
