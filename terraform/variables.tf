variable "incus_remote" {
  description = "Incus remote name"
  type        = string
}

variable "mavlan_parent_interface" {
  description = "Parent network interface for macvlan"
  type        = string
}

variable "zfs_storage_source" {
  description = "ZFS pool source"
  type        = string
}
