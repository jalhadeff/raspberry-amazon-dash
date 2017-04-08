#!/bin/sh

# Install Amazon AWS CLI SDK
# http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html
sudo apt-get install python3.4
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
pip install awscli --upgrade --user

# Install git and pull the amazon-dash repo
sudo apt-get install git

# Set the amazon-dash.sh to run on boot
