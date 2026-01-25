# Define all your VMs here
vms = {
  "seed-box" = {
    node_name      = "donnager"
    vm_id          = 202
    tags           = ["terraform", "ubuntu", "media"]
    template_id    = 9001
    cpu_cores      = 2
    cpu_sockets    = 2
    memory_mb      = 4096
    disk_datastore = "tank"
    disk_size_gb   = 50
    network_vlan_id = 10
    ip_address     = "192.168.10.101/24"
    ip_gateway     = "192.168.10.1"
  }

  # Example: Add more VMs easily
  # "dev-vm" = {
  #   node_name      = "donnager"
  #   vm_id          = 203
  #   tags           = ["terraform", "ubuntu", "development"]
  #   template_id    = 9001
  #   cpu_cores      = 4
  #   memory_mb      = 8192
  #   disk_datastore = "tank"
  #   disk_size_gb   = 100
  #   network_vlan_id = 10
  #   ip_address     = "192.168.10.102/24"
  # }

  # "automation-lxc" = {
  #   node_name      = "donnager"
  #   vm_id          = 204
  #   tags           = ["terraform", "lxc", "automation"]
  #   template_id    = 9002
  #   cpu_cores      = 2
  #   memory_mb      = 2048
  #   disk_datastore = "tank"
  #   disk_size_gb   = 20
  #   network_vlan_id = 10
  #   ip_address     = "192.168.10.103/24"
  # }
}
