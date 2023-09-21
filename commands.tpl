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

# Add server auto updating
cat <<EOF >> csgo-cron-jobs
*/5 * * * * /home/csgoserver/csgoserver monitor > /dev/null 2>&1
*/30 * * * * /home/csgoserver/csgoserver update > /dev/null 2>&1
0 0 * * 0 /home/csgoserver/csgoserver update-lgsm > /dev/null 2>&1
EOF
crontab csgo-cron-jobs
rm csgo-cron-jobs

# Create systemd for csgoserver to start on vm restart
sudo cat <<EOF >> /etc/systemd/system/csgoserver.service
[Unit]
Description=CS:GO Server

[Service]
Type=simple
User=your-username
WorkingDirectory=/home/csgoserver
ExecStart=/home/csgoserver/csgoserver start
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to make it aware of the new service unit
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable csgoserver.service

# Start csgo server
sudo systemctl start csgoserver.service
