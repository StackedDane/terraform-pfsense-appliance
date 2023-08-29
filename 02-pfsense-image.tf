# Upload VPN Appliance Image to OpenStack
resource "openstack_images_image_v2" "pfsense_image" {
  name             = "pfsense-2.7.0-amd64-image"
  image_source_url = "https://pfsense.object.storage.eu01.onstackit.cloud/pfsense-ce-2.7.0-amd64-14-08-2023.qcow2"
  web_download     = true
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "shared"
}
