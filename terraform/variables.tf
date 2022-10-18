variable "proxmox_token_id" {
  type = string

  description = "The proxmox api token id"
}

variable "proxmox_token_secret" {
  type = string

  description = "Proxmox api token secret"
}

variable "agent_count" {
  type    = number
  default = 2

  description = "The amount of agent vms that should be created"
}

variable "agent_disk_size" {
  type    = string
  default = "10G"

  description = "The disk size of the vms"
}

variable "storage_disk_size" {
  type    = string
  default = "1000G"

  description = "The disk size of the storage vms"
}

variable "proxmox_server" {
  type    = string

  description = "The proxmox server (IP, url, hostname) to connect to"
}

variable "proxmox_node" {
  type    = string
  default = "kenobi"

  description = "The proxmox node to create the vms on"
}

variable "proxmox_storage" {
  type    = string
  default = "media"

  description = "The proxmox storage that vms will use"
}

variable "gateway" {
  type    = string
  default = "10.0.0.1"

  description = "The gateway for the vms"
}

variable "ip_address" {
  type    = string
  default = "10.0.0.5"

  description = "Default IP address for the vms (10.0.0.5X)"
}

variable "cloudinit_template" {
  type    = string
  default = "focal-se-cloudinit"

  description = "The name of the template that should be used for the VMs"
}
