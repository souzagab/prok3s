output "agents" {
  value = tomap({
    for i, instance in proxmox_vm_qemu.kube-agent : i => {
      id         = instance.id
      ip_address = instance.default_ipv4_address
    }
  })
}
