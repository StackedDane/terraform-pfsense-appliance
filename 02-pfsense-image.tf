/*
Copyright 2023 Schwarz IT KG <markus.brunsch@mail.schwarz>
Copyright 2024-2025 STACKIT GmbH & Co. KG <markus.brunsch@stackit.cloud>

Use of this source code is governed by an MIT-style
license that can be found in the LICENSE file or at
https://opensource.org/licenses/MIT.
*/

# Local copy of the Image 
resource "null_resource" "pfsense_image_file" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "curl -o pfsense.qcow2 https://pfsense.object.storage.eu01.onstackit.cloud/pfsense-ce-2.7.2-amd64-10-12-2024.qcow2"
  }
  lifecycle {
    ignore_changes = all
  }
}

# Upload VPN Appliance Image to STACKIT
resource "stackit_image" "pfsense_image" {
  project_id      = var.STACKIT_PROJECT_ID
  name            = "pfsense-2.7.2-amd64-image"
  local_file_path = "./pfsense.qcow2"
  disk_format     = "qcow2"
  depends_on      = [null_resource.pfsense_image_file]
  min_disk_size   = 10
  min_ram         = 2
  config = {
    uefi = false
  }
}
