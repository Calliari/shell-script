#!/bin/bash

# Install PowerShell on ubuntu

# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install -y powershell



# ==================

# Start PowerShell
# pwsh

# Check if PowerShell is available in the linux env
# cat /etc/shells or 
# grep 'powershell' /etc/shells

# To make PowerShell the default shell 
# chsh -s /usr/bin/powershell

# update PowerShell 
# sudo yum update powershell

# Uninstallation powershell
# sudo yum remove powershell
