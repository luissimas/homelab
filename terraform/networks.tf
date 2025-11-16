resource "incus_network" "macvlan" {
  name = "macvlan0"
  type = "macvlan"

  config = {
    parent = var.mavlan_parent_interface
  }
}

