# STACKIT pfSense Deployment

Terraform script to deploy an pfSense firewall into STACKIT Cloud.

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

## Configure Access to the WebUI
In order to access the pfSense WebUI you need to configure the Appliance via the webVNC console first.

### Interface Mapping
The pfSense is asking for WAN and LAN interfaces.
WAN must be mapped to `vtnet0` LAN to `vtnet1`

### Enable WebUI Access
In the menu overview enter the Shell and type in the following two commands.

1. To disable the http referer check
    ```bash
    pfSsh.php playback disablereferercheck
    ```
1. Allow access from WAN to the WebUI
    ```bash
    pfSsh.php playback enableallowallwan
    ```
    > Keep in mind this rule creates an any to any (allow all) rule to the WAN interface. Please restrict the access again asap.

Now you can enter the WebUI via the FloatingIP on port 443 the default login is `admin:pfsense`