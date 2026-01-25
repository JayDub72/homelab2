# Define all your VMs here
# Provision nodes by hosts:
#   donnager: monitor
#   razorback: seedbox, mealie
#   rocinate: media

# Template IDs by host:
#   donnager: 9001
#   razorback: 9002
#   rocinate: 9003

vms = {
  "dev-vm" = {
    node_name      = "donnager"
    vm_id          = 2000
    tags           = ["terraform", "ubuntu", "dev"]
    template_id    = 9001
    cpu_cores      = 2
    memory_mb      = 4096
    disk_datastore = "local-lvm"
    disk_size_gb   = 50
    network_vlan_id = 10
    ip_address     = "dhcp"
  }

  "monitor" = {
    node_name      = "donnager"
    vm_id          = 500
    tags           = ["terraform", "ubuntu", "monitor"]
    template_id    = 9001
    cpu_cores      = 2
    memory_mb      = 4096
    disk_datastore = "local-lvm"
    disk_size_gb   = 25
    network_vlan_id = 10
    ip_address     = "192.168.10.145/24"
    ip_gateway     = "192.168.10.1"
  }

  "seedbox" = {
    node_name      = "razorback"
    vm_id          = 203
    tags           = ["terraform", "ubuntu", "media"]
    template_id    = 9002
    cpu_cores      = 4
    memory_mb      = 4096
    disk_datastore = "tank"
    disk_size_gb   = 50
    network_vlan_id = 10
    ip_address     = "192.168.10.99/24"
    ip_gateway     = "192.168.10.1"
  }

  "mealie" = {
    node_name      = "razorback"
    vm_id          = 400
    tags           = ["terraform", "ubuntu"]
    template_id    = 9002
    cpu_cores      = 2
    memory_mb      = 4096
    disk_datastore = "local-lvm"
    disk_size_gb   = 50
    network_vlan_id = 10
    ip_address     = "192.168.10.130/24"
    ip_gateway     = "192.168.10.1"
  }

  "media" = {
    node_name      = "rocinate"
    vm_id          = 201
    tags           = ["terraform", "ubuntu", "media"]
    template_id    = 9003
    cpu_cores      = 4
    memory_mb      = 12288
    disk_datastore = "local-lvm"
    disk_size_gb   = 100
    network_vlan_id = 10
    ip_address     = "192.168.10.102/24"
    ip_gateway     = "192.168.10.1"
  }

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
