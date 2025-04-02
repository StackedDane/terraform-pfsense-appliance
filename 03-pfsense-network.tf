/*
Copyright 2023 Schwarz IT KG <markus.brunsch@mail.schwarz>
Copyright 2024-2025 STACKIT GmbH & Co. KG <markus.brunsch@stackit.cloud>

Use of this source code is governed by an MIT-style
license that can be found in the LICENSE file or at
https://opensource.org/licenses/MIT.
*/

# Get vNET Networks
resource "stackit_network" "wan_network" {
  project_id       = var.STACKIT_PROJECT_ID
  name             = "wan_network"
  ipv4_nameservers = ["208.67.222.222", "9.9.9.9"]
}

resource "stackit_network" "lan_network" {
  project_id       = var.STACKIT_PROJECT_ID
  name             = "lan_network"
  ipv4_nameservers = ["208.67.222.222", "9.9.9.9"]
  ipv4_prefix      = var.LOCAL_SUBNET
  ipv4_gateway     = var.LOCAL_FIREWALL_IP
  routed           = false
}

resource "stackit_network_interface" "nic_wan" {
  project_id = var.STACKIT_PROJECT_ID
  network_id = stackit_network.wan_network.network_id
  security   = false
}

resource "stackit_network_interface" "nic_lan" {
  project_id = var.STACKIT_PROJECT_ID
  network_id = stackit_network.lan_network.network_id
  ipv4       = var.LOCAL_FIREWALL_IP
  security   = false
}

resource "stackit_public_ip" "wan-ip" {
  project_id           = var.STACKIT_PROJECT_ID
  network_interface_id = stackit_network_interface.nic_wan.network_interface_id
}
