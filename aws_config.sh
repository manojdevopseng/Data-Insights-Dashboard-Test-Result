#!/bin/bash

# Install AWS CLI
sudo apt-get update
sudo apt-get install -y awscli

# Install Chrome dependencies manually
RUN apt-get install -y libxss1 libappindicator3-1 libindicator3-7

# Install Chrome
wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
chmod +x /tmp/google-chrome-stable_current_amd64.deb
dpkg -i /tmp/google-chrome-stable_current_amd64.deb
apt-get install -yf

# Set AWS access key ID and secret access key
aws configure set aws_access_key_id #Your_Secrete_ID
aws configure set aws_secret_access_key #Your_Secret_Key
aws configure set default.region ap-south-1

# Run your Python script
python latestscript.py
