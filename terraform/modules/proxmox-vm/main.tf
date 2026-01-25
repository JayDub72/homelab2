terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.69.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = var.node_name
  vm_id     = var.vm_id
  tags      = var.tags

  agent {
    enabled = var.agent_enabled
  }

  clone {
    vm_id = var.template_id
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.disk_datastore
    interface    = var.disk_interface
    iothread     = var.disk_iothread
    discard      = var.disk_discard
    size         = var.disk_size_gb
  }

  network_device {
    bridge  = var.network_bridge
    vlan_id = var.network_vlan_id
  }

  initialization {
    dynamic "ip_config" {
      for_each = var.ip_address != "dhcp" && var.ip_address != null ? [1] : []
      content {
        ipv4 {
          address = var.ip_address
          gateway = var.ip_gateway
        }
      }
    }
    
    user_account {
      username = var.user_account_username
      keys     = var.user_account_ssh_keys
    }
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account[0].keys,
    ]
  }

  # Ansible provisioning
  provisioner "local-exec" {
    when    = create
    command = <<-EOT
      # Wait for SSH to be available
      timeout 300 bash -c 'until ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 ${var.user_account_username}@${self.ipv4_addresses[1][0]} echo "SSH ready"; do sleep 5; done'
      
      # Wait for cloud-init to finish
      ssh -o StrictHostKeyChecking=no ${var.user_account_username}@${self.ipv4_addresses[1][0]} 'cloud-init status --wait'
      
      # Run Ansible playbook if enabled
      if [ "${var.ansible_playbook_enabled}" = "true" ]; then
        cd ${var.ansible_playbook_path}
        ansible-playbook ${var.ansible_playbook_file} \
          --inventory $HOME/homelab2/ansible/inventory/hosts \
          --limit ${var.name} \
          --extra-vars "ansible_host=${self.ipv4_addresses[1][0]}" \
          --extra-vars "ansible_user=${var.user_account_username}" \
          --vault-password-file ${var.ansible_playbook_path}/.vault_pass
      fi
    EOT
  }
}