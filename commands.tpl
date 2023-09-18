# Sample apache2 setup to test firewall works
sudo apt-get update
sudo apt-get install -yq build-essential apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Install CSGO dependencies
sudo sudo apt install curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc1 lib32stdc++6 libsdl2-2.0-0:i386 -yq

# TODO: Implement non-interactive EULA Accept.
#sudo apt install steamcmd -yq

# Set iptables to allow port 27015
#iptables -I INPUT 6 -m state --state NEW -p tcp --dport 27015 -j ACCEPT
#iptables -I INPUT 6 -m state --state NEW -p udp --dport 27015 -j ACCEPT
#netfilter-persistent save

# Add a new user csgoserver. Add command to create password (optional)
#adduser csgoserver

# Add the user to the sudoers group, then change to the new user
#sudo usermod -aG sudo csgoserver
#su - csgoserver

# Get the script to install the cs server
#wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csgoserver

# get a steam token from https://steamcommunity.com/dev/managegameservers
# Use 730 for the App ID, and name your description anything you like. You’ll need to login to your steam account to do this part.

# Run the CS:GO server install (use default settings, hit enter when prompted, paste in token when prompted)
#./csgoserver install

# Start the server
#./csgoserver start

# TODO: Possible to extend to create systemd config to start the server and enable to startup.
# TODO: Possible to add server auto updating with below crontab config by running crontab -e or >> in to file. This needs to be done as csgoserver user.
# */5 * * * * /home/csgoserver/csgoserver monitor > /dev/null 2>&1
# */30 * * * * /home/csgoserver/csgoserver update > /dev/null 2>&1
# 0 0 * * 0 /home/csgoserver/csgoserver update-lgsm > /dev/null 2>&1