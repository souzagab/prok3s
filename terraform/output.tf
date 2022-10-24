output "masters" {
  value = tomap({
    for i, instance in proxmox_vm_qemu.kube-server : instance.name => {
      id         = instance.id
      ip_address = instance.default_ipv4_address
    }
  })
}

output "agents" {
  value = tomap({
    for i, instance in proxmox_vm_qemu.kube-agent : instance.name  => {
      id         = instance.id
      ip_address = instance.default_ipv4_address
    }
  })
}

output "storages" {
  value = tomap({
    for i, instance in proxmox_vm_qemu.kube-storage : instance.name  => {
      id         = instance.id
      ip_address = instance.default_ipv4_address
    }
  })
}
