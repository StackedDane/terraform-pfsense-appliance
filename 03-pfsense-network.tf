/*
Copyright 2023 Schwarz IT KG <markus.brunsch@mail.schwarz>
Copyright 2024 STACKIT GmbH & Co. KG <markus.brunsch@stackit.cloud>

Use of this source code is governed by an MIT-style
license that can be found in the LICENSE file or at
https://opensource.org/licenses/MIT.
*/

# Get vNET Networks
resource "stackit_network" "wan_network" {
  project_id         = var.STACKIT_PROJECT_ID
  name               = "wan_network"
  ipv4_nameservers        = ["208.67.222.222", "9.9.9.9"]
  routed             = true
}

resource "stackit_network" "lan_network" {
  project_id         = var.STACKIT_PROJECT_ID
  name               = "lan_network"
  ipv4_nameservers   = ["208.67.222.222", "9.9.9.9"]
  routed             = true
}

resource "stackit_security_group" "sec_group_wan" {
  project_id = var.STACKIT_PROJECT_ID
  name       = "sec_group"
  labels = {
    "key" = "value"
  }
}

resource "stackit_security_group_rule" "sec_icmp" {
  project_id        = var.STACKIT_PROJECT_ID
  security_group_id = stackit_security_group.sec_group_wan.security_group_id
  direction         = "ingress"
  icmp_parameters = {
    code = 0
    type = 8
  }
  protocol = {
    name = "icmp"
  }
}

resource "stackit_security_group_rule" "sec_tcp" {
  project_id        = var.STACKIT_PROJECT_ID
  security_group_id = stackit_security_group.sec_group_wan.security_group_id
  direction         = "ingress"
  port_range = {
    max = 443
    min = 443
  }
  protocol = {
    name = "tcp"
  }
}

resource "stackit_security_group" "sec_group_lan" {
  project_id = var.STACKIT_PROJECT_ID
  name       = "sec_group"
  labels = {
    "key" = "value"
  }
}

#resource "stackit_security_group_rule" "lan_sec_icmp" {
#  project_id        = var.STACKIT_PROJECT_ID
#  security_group_id = stackit_security_group.sec_group_lan.security_group_id
#  direction         = "ingress"
#  icmp_parameters = {
#    code = 0
#    type = 8
#  }
#  protocol = {
#    name = "icmp"
#  }
#}

#resource "stackit_security_group_rule" "lan_sec_tcp" {
#  project_id        = var.STACKIT_PROJECT_ID
#  security_group_id = stackit_security_group.sec_group_lan.security_group_id
#  direction         = "ingress"
#  port_range = {
#    max = 443
#    min = 443
#  }
#  protocol = {
#    name = "tcp"
#  }
#}

resource "stackit_network_interface" "nic_wan" {
  project_id         = var.STACKIT_PROJECT_ID
  network_id         = stackit_network.wan_network.network_id
  security_group_ids = [stackit_security_group.sec_group_wan.security_group_id]
}

resource "stackit_network_interface" "nic_lan" {
  project_id         = var.STACKIT_PROJECT_ID
  network_id         = stackit_network.lan_network.network_id
  security_group_ids = [stackit_security_group.sec_group_lan.security_group_id]
  depends_on         = [stackit_network_interface.nic_wan]
}

resource "stackit_public_ip" "example" {
  project_id           = var.STACKIT_PROJECT_ID
  network_interface_id = stackit_network_interface.nic_wan.network_interface_id
}
