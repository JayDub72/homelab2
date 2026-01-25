variable "name" {
  description = "VM name"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "vm_id" {
  description = "VM ID"
  type        = number
}

variable "tags" {
  description = "VM tags"
  type        = list(string)
  default     = []
}

variable "template_id" {
  description = "Template VM ID to clone from"
  type        = number
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "cpu_sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "memory_mb" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "disk_datastore" {
  description = "Datastore ID for disk"
  type        = string
}

variable "disk_interface" {
  description = "Disk interface type"
  type        = string
  default     = "scsi0"
}

variable "disk_iothread" {
  description = "Enable IO thread"
  type        = bool
  default     = true
}

variable "disk_discard" {
  description = "Discard mode"
  type        = string
  default     = "on"
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "network_vlan_id" {
  description = "VLAN ID"
  type        = number
  default     = null
}

variable "ip_address" {
  description = "Static IP address in CIDR notation (e.g., 192.168.10.101/24)"
  type        = string
}

variable "ip_gateway" {
  description = "Default gateway"
  type        = string
}

variable "agent_enabled" {
  description = "Enable QEMU guest agent"
  type        = bool
  default     = true
}

variable "user_account_username" {
  description = "Username for cloud-init user account"
  type        = string
  default     = "ubuntu"
}

variable "user_account_ssh_keys" {
  description = "SSH public keys for user account"
  type        = list(string)
  default     = []
}
