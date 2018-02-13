variable "do_token" {
  type = "string"
  description = "Digital Ocean API Token"
  default     = "67b9a5f988add3566b8b9f120ffb5ceab8f1ef7ade0e37d108339c93d2eb2f18"
}

variable "do_region" {
  default     = "lon1"
  description = "The DigitalOcean Region to launch the cluster in"
}

variable "do_image" {
  default     = "centos-7-x64"
  description = "The DigitalOcean droplet image to use for all nodes"
}

variable "do_droplet_size" {
  default     = "2gb"
  description = "The DigitalOcean droplet size to use for Sensu instances"
}

variable "ssh_key" {
  type = "string"
  description = "SSH Key for remote access"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD2vzd/hBCSzPCspYruyktfOEvU/jhVSToi6wmWR8rj484913L9PVWCWpjORNdtBUThg9HsiK9vWsr9cvYBF/wxChxhK+Rb9px5RwkITJWQSzwM2CqKW8fpDMXhCbJyljXduChAg2PmzfAKHcZmZvzw2l5LDL7jWaB2M53xf5yi+YgarEQ6hX1JNy+9ScVhLGUAHuBUSBQb9esusk4IOZmao683UP2YZOqaE9/F7VgQ99Zge2VK4evxYtXSO1TbzuBkzDeg6aUvvNtkuS+d/XxT8GMunPUFxhX5MrBAsFCVBml6+59cqU73UEOfb1BfUVtV5/x2Axir7yyllyWoTUz"
}

variable "sensu_domain" {
  type = "string"
  description = "DNS zone for the demo"
  default     = "sensu.thomasriley.co.uk"
}

variable "sensu_alpha_token" {
  type = "string"
  description = "Token for Sensu Alpha repos"
  default     = "dbe3ac2ef5145a93f67f02ca2d03f5aa5ab8593ec9189415"
}

variable "sensu_droplet_count" {
  description = "Number of Sensu servers"
  default     = 1
}

variable "cluster_name" {
  default     = "sensu-terraform-demo"
  description = "The name of the Sensu cluster"
}
