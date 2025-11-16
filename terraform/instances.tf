resource "incus_instance" "k3s_node" {
  name        = "k3s-node"
  type        = "container"
  image       = "images:debian/13"
  description = "Container for the main K3s cluster"

  config = {
    "limits.cpu"           = 4
    "limits.memory"        = "16GiB"
    "security.privileged"  = true
    "security.nesting"     = true
    "linux.kernel_modules" = "overlay,nf_nat,ip_tables,ip6_tables,netlink_diag,br_netfilter,xt_conntrack,nf_conntrack,ip_vs,vxlan"
    "raw.lxc"              = <<EOT
lxc.apparmor.profile = unconfined
lxc.mount.auto=proc:rw sys:rw cgroup:rw
lxc.cap.drop =
lxc.cgroup.devices.allow = a
lxc.cgroup2.devices.allow = a
EOT
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

  # Kubelet needs access /dev/kmsg for logging
  device {
    name = "kmsg"
    type = "unix-char"
    properties = {
      source = "/dev/kmsg"
      path   = "/dev/kmsg"
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
