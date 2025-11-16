resource "incus_storage_pool" "default" {
  name   = "default"
  driver = "zfs"

  config = {
    source = var.zfs_storage_source
  }
}

