# Auto-generated Ansible inventory from Terraform
# Generated at: ${timestamp()}

[all]
%{ for name, vm in vms ~}
${name} ansible_host=${vm.ip}
%{ endfor ~}

# Groups based on tags
%{ for name, vm in vms ~}
%{ for tag in vm.tags ~}
[${tag}]
%{ if contains(vm.tags, tag) ~}
${name}
%{ endif ~}
%{ endfor ~}
%{ endfor ~}

[all:vars]
ansible_user=ubuntu
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

