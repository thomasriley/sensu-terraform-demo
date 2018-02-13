#!/bin/bash

# Install the Sensu Alpha repos
export SENSU_REPO_TOKEN=${sensu_alpha_token}
curl -s https://$SENSU_REPO_TOKEN:@packagecloud.io/install/repositories/sensu/prerelease/script.rpm.sh | sudo bash

# Install the Sensu pakcages
sudo yum -y install sensu-backend sensu-agent sensu-cli

# Copy the example configuration files
sudo cp /etc/sensu/backend.yml.example /etc/sensu/backend.yml
sudo cp /etc/sensu/agent.yml.example /etc/sensu/agent.yml

# Start the Sensu Backend and Agent services
systemctl start sensu-backend
sleep 5
systemctl start sensu-agent

# Configure sensuctl
mkdir -p /root/.config/sensu/sensuctl
cat <<EOT >> /root/.config/sensu/sensuctl/profile
{
  "environment": "default",
  "format": "tabular",
  "organization": "default"
}
EOT

cat <<EOT >> /root/.config/sensu/sensuctl/cluster
{
  "api-url": "http://localhost:8080",
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MTg1NTkxMzQsImp0aSI6IjE1MDZkYmFmMGIwMzRhYzc4YjM2YjNjNmQ4YzhlYjM3Iiwic3ViIjoiYWRtaW4ifQ.UYJ9Fbp9Qpq-MVMvyXmqb_uWk3McCjgEXhwn7k30S5I",
  "expires_at": 1518559134,
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlMGYyOTIzMWJjOTNkYTA1ZGJmNDA4N2I1MGY0YzcyZSIsInN1YiI6ImFkbWluIn0.vGtpwBBlbJCbjeE45h89f7uQWPLoMpc_wh2cjou2a6w"
}
EOT

# Touch this file so that the Terraform provisioner completes
touch /tmp/script_finished
