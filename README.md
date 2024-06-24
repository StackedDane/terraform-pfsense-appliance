# STACKIT pfSense Deployment (**Network Area Version**)

Terraform script to deploy an pfSense firewall into a STACKIT Cloud Project with enabled **Network Area**.

> If you are unsure if your project is using a network area please refer to the main branch.

Deployment overview:
![](deployment.svg)

The Terraform deployment consists of:
+ Creating two SNA networks (WAN, LAN)
+ pfSense firewall VM + disk volume
+ FloatingIP for firewall VM
+ deactivating port security on firewall ports

## Setup
**Requirements:**
+ Terraform installed
+ Access to a STACKIT project with **enabled Network Area**
+ UAT (OpenStack) credentials
+ Create a [STACKIT Service Account](https://docs.stackit.cloud/stackit/en/getting-started-in-service-accounts-134415831.html) & Grant the Service Account Admin permissions on the Project

### Installation
1. Clone Repo
1. Setup enviroment (.env) variables
1. Run Terraform `terraform apply`
1. Create a [static Route](https://docs.stackit.cloud/stackit/en/manage-a-sna-194707707.html#ManageaSNA-Staticroutes) for the Remote Network

## Default Configuration

### Interfaces
1. `vtnet0` WAN
1. `vtnet1` LAN

### NAT
Masqurade (Outbound NAT) Traffic from `LAN` to `WAN`

### DNS
Disable build in unbound DNS resolver and forward all DNS queries to public DNS Servers OpenDNS & Quad9

### Dashboard
Customized Widgets and CSS settings

### Password
Set default password for admin to STACKIT123!

### Interface Access
Disabled Referer-Check
Enable allow all wan adresses to connect to the WebUI

Now you can enter the WebUI via the FloatingIP on port 443 the default login is admin:STACKIT123!