# STACKIT pfSense Deployment (High Availability)

Terraform script to deploy an pfSense firewall Cluster into STACKIT Cloud.

Deployment overview:
![](deployment.svg)

The Terraform deployment consists of:
+ WAN Network
+ WAN Router with external RouterIP
+ LAN Network
+ LAN Router with static default gateway router to the pfSense firewall
+ pfSense firewall VM + disk volume
+ FloatingIP for firewall VM
+ deactivating port security on firewall ports

## Setup
**Requirements:**
+ Terraform installed
+ Access to a STACKIT project
+ UAT (OpenStack) credentials

### Installation
1. Clone Repo
1. Setup enviroment (.env) variables
1. Run Terraform `terraform apply`

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

> Note: You need to manually initialize the cluster please refer to [the official docs](https://docs.netgate.com/pfsense/en/latest/recipes/high-availability.html).