#!/bin/sh

# Generte a MDTD
# http://patorjk.com/software/taag/#p=testall&f=Big&t=My%20-%20Server

sudo apt-get install -y cowsay

sudo apt-get install landscape-common -y

sudo hostname my-server

sudo mkdir -p /etc/update-motd.d-available

sudo mv /etc/update-motd.d/* /etc/update-motd.d-available/


sudo tee /etc/update-motd.d-available/99-custom_footer <<'EOF'
#!/bin/bash
#
# Provides MOTD with some sysinfo.
#
# @author Calliari


HOSTNAME=$(hostname)
CURRENT_SYSINFO=$(/usr/bin/landscape-sysinfo)

REBOOT=""
if [ -x /usr/lib/update-notifier/update-motd-reboot-required ]; then
  REBOOT=$(/usr/lib/update-notifier/update-motd-reboot-required)
  if [ "$REBOOT" != "" ]; then
    REBOOT="\n\n$REBOOT"
  fi
fi

LOGO="
  ███╗   ███╗██╗   ██╗              ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗
  ████╗ ████║╚██╗ ██╔╝              ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗
  ██╔████╔██║ ╚████╔╝     █████╗    ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝
  ██║╚██╔╝██║  ╚██╔╝      ╚════╝    ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗
  ██║ ╚═╝ ██║   ██║                 ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║
  ╚═╝     ╚═╝   ╚═╝                 ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝
 \n"

/bin/echo -e "\n$LOGO\nWelcome to the MY SERVER Server! [$HOSTNAME]\n\nDeploys should be managed through Jenkins.\n\nSpeak to  (System Administrator) if any issues.\n\nCurrent information:\n$CURRENT_SYSINFO $REBOOT\n" | /usr/games/cowsay -n

EOF

sudo chmod +x /etc/update-motd.d-available/99-custom_footer

sudo ln -s /etc/update-motd.d-available/99-custom_footer /etc/update-motd.d/99-custom_footer
