# Deployment and validation notes

## Environment

- AWS Region: Europe (London), `eu-west-2`
- Operating system: Amazon Linux 2023
- Instance family: `t3.micro`
- Web server: Nginx
- Network: custom VPC with public and private subnets

## Linux commands used

```bash
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl enable --now nginx
sudo systemctl status nginx
curl -s http://localhost
```

The custom static website was placed at:

```text
/usr/share/nginx/html/index.html
```

## Validation evidence

- EC2 instance status checks: 3/3 passed.
- SSH login as `ec2-user` succeeded.
- `nginx.service` reported `active (running)` and `enabled`.
- The custom page was served over HTTP and loaded in a browser.
- CloudWatch displayed EC2 CPUUtilization and the configured alarm reached OK during testing.

## Access rules

- SSH TCP/22: restricted to the administrator's public IP using a /32 source.
- HTTP TCP/80: open to the internet for public website access.

Do not commit private key files, credentials, AWS account IDs, or screenshots containing unredacted IP addresses.

## Operational caveats

The website uses HTTP, not HTTPS. The alarm has no SNS notification or automated remediation. One NAT Gateway serves private subnets in two Availability Zones, which is a lab cost/availability trade-off rather than a highly available production design.
