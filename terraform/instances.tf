resource "incus_instance" "k3s_node" {
  name        = "k3s-node"
  type        = "container"
  image       = "images:alpine/3.22"
  description = "Container for the main K3s cluster"

  config = {
    "limits.cpu"       = 4
    "limits.memory"    = "16GiB"
    "security.nesting" = true
  }

  device {
    name = "root"
    type = "disk"

    properties = {
      path = "/"
      size = "50GiB"
      pool = incus_storage_pool.default.name
    }
  }

  device {
    name = "data"
    type = "disk"

    properties = {
      path   = "/mnt/data"
      source = incus_storage_volume.k3s_data.name
      pool   = incus_storage_pool.default.name
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

  wait_for {
    type = "ipv4"
    nic  = "eth0"
  }
}

resource "incus_storage_volume" "k3s_data" {
  name         = "k3s-data"
  pool         = incus_storage_pool.default.name
  content_type = "filesystem"
  description  = "Stores persistent data (e.g. media) for the K3s cluster"

  config = {
    size = "750GiB"
  }
}
