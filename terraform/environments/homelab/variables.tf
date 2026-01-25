variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_api_username" {
  description = "Proxmox API username"
  type        = string
}

variable "proxmox_api_password" {
  description = "Proxmox API password"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Allow insecure connections to Proxmox"
  type        = bool
  default     = true
}

variable "default_network_bridge" {
  description = "Default network bridge"
  type        = string
  default     = "vmbr0"
}

variable "default_gateway" {
  description = "Default gateway for VMs"
  type        = string
  default     = "192.168.10.1"
}

variable "vm_user_account_username" {
  description = "Default username for VMs"
  type        = string
  default     = "ubuntu"
}

variable "vm_user_account_ssh_keys" {
  description = "SSH public keys for VM access"
  type        = list(string)
  default     = []
}

variable "vms" {
  description = "Map of VMs to create"
  type = map(object({
    node_name      = string
    vm_id          = number
    tags           = list(string)
    template_id    = number
    cpu_cores      = number
    cpu_sockets    = optional(number, 1)
    memory_mb      = number
    disk_datastore = string
    disk_size_gb   = number
    disk_interface = optional(string, "scsi0")
    disk_iothread  = optional(bool, true)
    disk_discard   = optional(string, "on")
    network_bridge = optional(string)
    network_vlan_id = optional(number)
    ip_address     = string
    ip_gateway     = optional(string)
    agent_enabled  = optional(bool, true)
  }))
  default = {}
}
