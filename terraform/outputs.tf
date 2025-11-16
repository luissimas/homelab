output "storage_pool_name" {
  value = incus_storage_pool.default.name
}

output "network_name" {
  value = incus_network.macvlan.name
}
