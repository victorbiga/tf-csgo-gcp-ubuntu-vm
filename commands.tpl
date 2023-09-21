# Install CSGO dependencies
sudo dpkg --add-architecture i386; sudo apt update
sudo apt install curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0:i386 -yq

# Install google ops-agent
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Implement non-interactive EULA Accept.
sudo debconf-set-selections <<EOF
steam steam/question select I AGREE
steam steam/license note
EOF
sudo apt install steamcmd -yq

# Set iptables to allow port 27015
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 27015 -j ACCEPT
sudo iptables -I INPUT 6 -m state --state NEW -p udp --dport 27015 -j ACCEPT
# TODO: command does not exist
# netfilter-persistent save

# Add a new user csgoserver. Add command to create password (optional)
sudo useradd -m -s /bin/bash csgoserver

# Add the user to the sudoers group, then change to the new user
sudo usermod -aG sudo csgoserver
sudo -i -u csgoserver

# Get the script to install the cs server
wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csgoserver

# get a steam token from https://steamcommunity.com/dev/managegameservers
# Use 730 for the App ID, and name your description anything you like. You’ll need to login to your steam account to do this part.
# Run the CS:GO server install (use default settings, hit enter when prompted, paste in token when prompted)
# ./csgoserver install
# non-interactive install
./csgoserver auto-install

# Start the server
#./csgoserver start

# TODO: Possible to extend to create systemd config to start the server and enable to startup.
# TODO: Possible to add server auto updating with below crontab config by running crontab -e or >> in to file. This needs to be done as csgoserver user.
# */5 * * * * /home/csgoserver/csgoserver monitor > /dev/null 2>&1
# */30 * * * * /home/csgoserver/csgoserver update > /dev/null 2>&1
# 0 0 * * 0 /home/csgoserver/csgoserver update-lgsm > /dev/null 2>&1
