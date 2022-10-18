terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}
