# Create SSH Key for remote access
resource "digitalocean_ssh_key" "sensu" {
  name       = "Sensu Terraform Demo"
  public_key = "${var.ssh_key}"
}

# Create a new DNS zone / domain
resource "digitalocean_domain" "sensu" {
  name       = "${var.sensu_domain}"
  ip_address = "127.0.0.1"
}

# Create tags for tagging resources
resource "digitalocean_tag" "sensu_instance" {
  name = "${var.cluster_name}-sensu-instance"
}

# Create the bootstrap script for the node
data "template_file" "sensu_bootstrap" {
  template = "${file("${path.module}/etc/scripts/sensu_bootstrap.sh.tpl")}"

  vars {
    sensu_alpha_token = "${var.sensu_alpha_token}"
  }
}

# Create Sensu instance(s)
resource "digitalocean_droplet" "sensu_node" {
  count              = "${var.sensu_droplet_count}"
  image              = "${var.do_image}"
  name               = "${var.cluster_name}-${count.index}"
  region             = "${var.do_region}"
  size               = "${var.do_droplet_size}"
  private_networking = false
  ssh_keys           = ["${digitalocean_ssh_key.sensu.fingerprint}"]
  tags               = ["${digitalocean_tag.sensu_instance.id}"]
  user_data          = "${data.template_file.sensu_bootstrap.rendered}"

  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /tmp/script_finished ]; do sleep 2; done",
    ]
  }
}

# Create DNS names for Sensu instance(s)
resource "digitalocean_record" "sensu_instances" {
  count  = "${var.sensu_droplet_count}"
  domain = "${digitalocean_domain.sensu.name}"
  type   = "A"
  ttl    = 30
  name   = "${element(digitalocean_droplet.sensu_node.*.name, count.index)}"
  value  = "${element(digitalocean_droplet.sensu_node.*.ipv4_address, count.index)}"
}

# Create firewall rules for Sensu instance(s)
resource "digitalocean_firewall" "sensu" {
  name = "${var.cluster_name}-sensu-ports"

  droplet_ids = ["${digitalocean_droplet.sensu_node.*.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "3000"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "8080"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "53"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "53"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}
