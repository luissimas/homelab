terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "1.0.0"
    }
  }
}

provider "incus" {
  accept_remote_certificate = true
  default_remote            = var.incus_remote
}
