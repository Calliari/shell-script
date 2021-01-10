#!/bin/bash

# Install PowerShell on ubuntu

# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of products
sudo apt-get update
# Enable the "universe" repositories
sudo add-apt-repository universe
# Install PowerShell
sudo apt-get install -y powershell


# ==================

# Start PowerShell
# pwsh

# Check if PowerShell is available in the linux env
# cat /etc/shells or 
# grep 'powershell' /etc/shells

# To make PowerShell the default shell 
# chsh -s /usr/bin/powershell

# update PowerShell 
# sudo apt update powershell

# Uninstallation powershell
# sudo apt remove powershell