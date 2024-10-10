/*
Copyright 2023-2024 Schwarz IT KG <markus.brunsch@mail.schwarz>

Use of this source code is governed by an MIT-style
license that can be found in the LICENSE file or at
https://opensource.org/licenses/MIT.
*/

# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "3.0.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name         = var.USERNAME
  tenant_id         = var.TENANTID
  user_domain_name  = "portal_mvp"
  project_domain_id = "portal_mvp"
  password          = var.PASSWORD
  auth_url          = "https://keystone.api.iaas.eu01.stackit.cloud/v3/"
  region            = "RegionOne"
}
