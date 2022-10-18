provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_server}:8006/api2/json"

  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret


  pm_tls_insecure = true
}

provider "random" {}
provider "null" {}

resource "proxmox_vm_qemu" "kube-server" {
  count = 1
  name  = "k3s-control-plane"

  target_node = var.proxmox_node

  vmid = "100${count.index + 1}"

  clone = var.cloudinit_template

  agent   = 1
  os_type = "cloud-init"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 4096
  scsihw  = "virtio-scsi-pci"

  bootdisk = "scsi0"

  disk {
    slot    = 0
    size    = var.agent_disk_size
    type    = "scsi"
    storage = var.proxmox_storage
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }

  ipconfig0 = "ip=${var.ip_address}${count.index + 1}/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "kube-agent" {
  count = var.agent_count
  name  = "k3s-agent-0${count.index + 1}"

  target_node = var.proxmox_node

  vmid = "200${count.index + 1}"

  clone = var.cloudinit_template

  agent   = 1
  os_type = "cloud-init"

  cores    = 2
  sockets  = 1
  cpu      = "host"
  memory   = 4096
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot    = 0
    size    = var.agent_disk_size
    type    = "scsi"
    storage = var.proxmox_storage
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }

  ipconfig0 = "ip=${var.ip_address}${count.index + 1}/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "kube-storage" {
  count       = 1
  name        = "k3s-storage-0${count.index + 1}"
  target_node = var.proxmox_node
  vmid        = "300${count.index + 1}"

  clone = var.cloudinit_template

  agent    = 1
  os_type  = "cloud-init"
  cores    = 2
  sockets  = 1
  cpu      = "host"
  memory   = 4096
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot    = 0
    size    = var.storage_disk_size
    type    = "scsi"
    storage = var.proxmox_storage
  }


  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }

  ipconfig0 = "ip=${var.ip_address}${count.index + 1}/24,gw=${var.gateway}"
}
