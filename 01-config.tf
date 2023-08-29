#
# Custom User Settings
#

# OpenStack Availability Zone
variable "zone" {
  type        = string
  description = ""
  default     = "eu01-m"
}

# OpenStack VM Flavor
variable "flavor" {
  type        = string
  description = ""
  default     = "c1.2"
}

# Local VPC Subnet to create OpenStack Network
variable "LOCAL_SUBNET" {
  type        = string
  description = ""
  default     = "10.0.0.0/24"
}

############################################

#
# System Settings (do not edit)
#

# OpenStack UAT Username
variable "USERNAME" {
  type        = string
  description = ""
}

# OpenStack Project ID
variable "TENANTID" {
  type        = string
  description = ""
}

# OpenStack UAT Password
variable "PASSWORD" {
  type        = string
  description = ""
}
