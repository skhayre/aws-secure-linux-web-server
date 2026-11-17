#!/bin/bash
set -euo pipefail

# Install and start Nginx on Amazon Linux 2023.
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl enable --now nginx
sudo systemctl status nginx --no-pager
