output "sensu_instances" {
  value = "${digitalocean_record.sensu_instances.*.fqdn}"
}
