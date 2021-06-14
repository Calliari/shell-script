#  Package Manager for MacOS (https://docs.brew.sh/Installation)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# ==========================================
# Install vagrant (https://www.vagrantup.com/downloads)
brew tap hashicorp/tap
brew install vagrant

# ==========================================


# Download the bin (terraform) and make create a synclink
cd /Users/$USER/devOps/terraform/
curl "https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_darwin_amd64.zip" -O /Users/$USER/devOps/terraform/
unzip /Users/$USER/devOps/terraform/terraform_1.0.0_darwin_amd64.zip
mv /Users/$USER/devOps/terraform/terraform /Users/$USER/devOps/terraform/terraform-v1.0
ln -s /Users/$USER/devOps/terraform/terraform-v1.0 /usr/local/bin/terraform

# ==========================================

# Download the bin (ansible) and make create a synclink
cd ~/
python3 -m pip install --user ansible
ln -s /Users/$USER/Library/Python/3.9/bin/ansible /usr/local/bin/anible

# ==========================================

# Download the bin (aws) and make create a synclink
cd /tmp/
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg ./AWSCLIV2.pkg -target /
ln -s /usr/local/aws-cli/aws /usr/local/bin/

# ==========================================
# To make an alias i.e:

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias ll='ls -lsaF'
alias la='ls -A'

alias vg='vagrant'
alias pck='packer'
alias tf='terraform'

