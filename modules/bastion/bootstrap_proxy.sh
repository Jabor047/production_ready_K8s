!#/bin/bash

sudo apt-get update && apt-get install -y tinyproxy
grep -qxf 'Allow localhost' /etc/tinyproxy/tinyproxy.conf || echo 'Allow localhost' >> /etc/tinyproxy/tinyproxy.conf
sudo systemctl restart tinyproxy
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install