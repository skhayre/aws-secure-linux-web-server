# Deployment Guide — AWS Secure Linux Web Server

## 1. Project Environment

- **Cloud provider:** AWS
- **Region:** Europe (London) — `eu-west-2`
- **Operating system:** Amazon Linux 2023
- **Instance type:** `t3.micro`
- **Web server:** Nginx

## 2. Network Configuration

Created a custom VPC with the following configuration:

| Component | CIDR |
|---|---|
| VPC | `10.0.0.0/16` |
| Public subnet 1 | `10.0.1.0/24` |
| Public subnet 2 | `10.0.2.0/24` |
| Private subnet 1 | `10.0.11.0/24` |
| Private subnet 2 | `10.0.12.0/24` |

Configured:
- Internet Gateway for public internet connectivity.
- Public route table directing internet traffic to the Internet Gateway.
- NAT Gateway allowing private subnets to access the internet outbound.
- Private route table directing outbound internet traffic through the NAT Gateway.

## 3. EC2 Deployment

Launched an EC2 instance with:
- Amazon Linux 2023.
- `t3.micro` instance type.
- Public subnet 1.
- An associated security group.
- SSH key-pair authentication.

Connected to the instance using SSH:

```bash
ssh -i secure-web-server-key.pem ec2-user@<EC2-PUBLIC-IP>
```

The private key was kept locally and was not uploaded to GitHub.

## 4. Security Group Configuration

| Protocol | Port | Source | Purpose |
|---|---:|---|---|
| SSH | 22 | Administrator IP `/32` | Remote administration |
| HTTP | 80 | `0.0.0.0/0` | Public website access |

SSH access was restricted to a specific administrator IP rather than being exposed to the entire internet.

## 5. Linux Server Configuration

Updated the Amazon Linux system:

```bash
sudo dnf update -y
```

Installed Nginx:

```bash
sudo dnf install nginx -y
```

Enabled and started the Nginx service:

```bash
sudo systemctl enable --now nginx
```

Verified the service:

```bash
sudo systemctl status nginx
```

## 6. Website Deployment

Created a custom HTML webpage in the Nginx web root:

```bash
sudo tee /usr/share/nginx/html/index.html
```

The deployed page displays project information, server details and a server-online status.

Verified the webpage using the EC2 public IP address over HTTP.

## 7. CloudWatch Monitoring

Created a CloudWatch alarm to monitor EC2 CPU utilisation.

| Setting | Configuration |
|---|---|
| Metric | `CPUUtilization` |
| Statistic | Average |
| Period | 5 minutes |
| Threshold | Greater than 70% |
| Alarm name | `secure-web-server-high-cpu` |

The alarm reached the **OK** state, indicating CPU utilisation was below the configured threshold at that time.

No SNS email notifications or automated recovery actions were configured.

## 8. Security and Limitations

- SSH restricted to an administrator IP.
- Private SSH key excluded from the repository.
- HTTP enabled for public website access.
- HTTPS was not configured.
- One EC2 instance was deployed.
- One NAT Gateway serves both private subnets.

This is a practical learning environment rather than a production-ready high-availability architecture.

## 9. Potential Improvements

- Configure HTTPS using a domain and TLS certificate.
- Introduce an Application Load Balancer.
- Deploy instances across multiple Availability Zones.
- Configure SNS notifications for CloudWatch alarms.
- Explore automated infrastructure deployment using Terraform.
