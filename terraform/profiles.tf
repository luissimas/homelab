resource "incus_profile" "default" {
  name = "default"

  device {
    name = "root"
    type = "disk"

    properties = {
      path = "/"
      pool = incus_storage_pool.default.name
    }
  }

  device {
    name = "eth0"
    type = "nic"

    properties = {
      network = incus_network.macvlan.name
      name    = "eth0"
    }
  }
}
