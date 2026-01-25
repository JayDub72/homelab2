   terraform {
  required_version = ">= 1.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.69.0"
    }
  }

  # Optional: Configure remote state
  # backend "s3" {
  #   bucket = "my-terraform-state"
  #   key    = "homelab/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "proxmox" {
  endpoint = var.proxmox_api_url
  username = var.proxmox_api_username
  password = var.proxmox_api_password
  insecure = var.proxmox_insecure

  ssh {
    agent = true
  }
}
