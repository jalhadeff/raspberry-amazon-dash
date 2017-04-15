#!/bin/sh

# The producing plant of our amazon-dash will run this script when on the device.

# This script will
# 1. Install the amazon-dash logic
# 2. Keep the amazon-dash logic updated
# 3. Recover if the device crashes or reboots

# Install git
sudo apt-get install git

# pull the amazon-dash repo
cd ~
git clone https://github.com/jalhadeff/raspberry-amazon-dash.git

# Now we want to make this script run automatically,
# see: https://raspberrypi.stackexchange.com/questions/8734/execute-script-on-start-up#8735
sudo mv amazon-dash.sh /etc/init.d/

# Make the script executable:
sudo chmod 755 /etc/init.d/amazon-dash.sh

# Set the amazon-dash.sh to run on boot so that we can recover from
# any bug, crash and power shortage 
sudo update-rc.d amazon-dash.sh defaults

# Check for updates daily
# See http://www.cronmaker.com/
# See https://www.raspberrypi.org/documentation/linux/usage/cron.md
# http://www.linuxquestions.org/questions/linux-software-2/writing-a-crontab-file-111381/#post574981
cronjob = "0 0 2 1/1 * ? * git clone https://github.com/jalhadeff/raspberry-amazon-dash.git && mv amazon-dash.sh /etc/init.d/"
sudo echo cronjob >> /etc/crontab
