#!/bin/bash
set -e

sudo -i <<'ROOT_EOF'

echo "${instance_name}" > /etc/hostname

apt-get update
apt-get install -y python3 python3-venv python3-pip jq nginx unzip

mkdir temp-aws
cd temp-aws
curl -sLO 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
unzip awscli-exe-linux-x86_64.zip
./aws/install
cd && rm -rf temp-aws

wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/
cat <<EOF >/opt/aws/amazon-cloudwatch-agent/etc/config.json
{
"metrics": {
"metrics_collected": {
"cpu": {
"measurement": ["cpu_usage_idle", "cpu_usage_user", "cpu_usage_system"],
"metrics_collection_interval": 60
}
},
"append_dimensions": {
"AutoScalingGroupName": "aws:AutoScalingGroupName","InstanceId":"{aws:InstanceId}"
}
}
}
EOF

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json -s

# Go to /opt and clone the repo
cd /opt
git clone https://github.com/cognetiks/Technical_DevOps_app.git
cd Technical_DevOps_app/

# Create and activate Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Upgrade pip and install dependencies
pip install --upgrade pip
pip install -r requirements.txt
pip install boto3

systemctl enable nginx
systemctl start nginx