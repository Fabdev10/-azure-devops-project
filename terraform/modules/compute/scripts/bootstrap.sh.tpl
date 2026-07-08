#!/bin/bash
set -euo pipefail

apt-get update
apt-get install -y docker.io
systemctl enable docker
systemctl start docker
usermod -aG docker ${admin_username}
