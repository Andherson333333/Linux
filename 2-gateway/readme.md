# Linux Network Configuration Script

## Description

This interactive Bash script simplifies network configuration on Linux systems, guiding the user through the setup of network interface, IP address, netmask, gateway, and the creation of configuration files.

## Contents

- [Script Usage](#script-usage)
- [Script Execution](#script-execution)
- [Features](#features)
- [Additional Notes](#additional-notes)

## Script Usage

1. Execute the script in your terminal:
   ```bash
   bash script_name.sh
   ```
2. Follow the interactive instructions to configure your network.

## Script Execution

### Interface Selection
- The script will display a list of available interfaces.
- Select an interface from the provided list.

### IP Address Configuration
- Enter the desired IP address when prompted.

### Netmask Configuration
- Enter the netmask. Make sure to follow the correct format (example: 255.255.255.0).

### Network and Gateway Configuration
- Enter the network and gateway. The entries will be validated for correctness.

## Features

### Generation of Configuration Files
- Creates the `rt_tables` file to assign a routing table to the selected interface.
- Creates the `interfaces` file with network configuration for the selected interface.
- Creates the `boot.sh` file that establishes routing rules and outbound rules.

### File Permissions and Execution
- Grants execution permissions to the generated files.
- Executes `boot.sh` to apply the network configuration.

### Automatic Configuration on Reboot
- Adds lines to the `/etc/iproute2/rt_tables` file.
- Adds lines to the `/etc/network/interfaces` file.
- Configures the `boot.sh` script to run on each system reboot.

### Gateway Ping
- Creates the `pingw.sh` file that pings the gateway.
- Executes `pingw.sh` and schedules it in cron to run every 5 minutes.

## Additional Notes

### Security Considerations
- The script assumes it will be run with administrator (root) privileges.
- Make sure to review and adjust the configuration according to your specific needs.

### Additional Information
- The configuration is based on user inputs provided during script execution.
- Basic validity checks are performed on the provided inputs.

### Activity Logging
- The files `rt_tables`, `interfaces`, and `boot.sh` are generated and record the applied configuration.

This script facilitates network configuration and automation in Linux environments. Be sure to review and customize the configuration according to your specific needs before running it.
