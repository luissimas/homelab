output "storage_pool_name" {
  value = incus_storage_pool.default.name
}

output "network_name" {
  value = incus_network.macvlan.name
}

output "k3s_node_ip" {
  value = incus_instance.k3s_node.ipv4_address
}
