# AWS Secure Linux Web Server

A hands-on AWS cloud engineering project: build a custom VPC, deploy an Amazon Linux 2023 EC2 instance, host a website with Nginx, and monitor compute health with CloudWatch.

**Region:** Europe (London) — `eu-west-2`  
**Status:** Deployed and reachable over HTTP  
**Project type:** Learning lab — not production-ready

## Project overview

This project demonstrates practical cloud and Linux administration skills across networking, compute, access control, web hosting and monitoring.

## Architecture

[Open the architecture diagram](architecture/aws-architecture.md)

The environment contains:

- A custom VPC with CIDR `10.0.0.0/16`.
- Two public subnets and two private subnets across two Availability Zones.
- An Internet Gateway for public subnet connectivity.
- A NAT Gateway providing outbound internet access for the private subnets.
- An Amazon EC2 `t3.micro` instance running Amazon Linux 2023.
- Nginx serving a custom static webpage.
- CloudWatch EC2 CPU metrics and a threshold alarm.

### Network layout

| Component | CIDR / placement | Purpose |
|---|---|---|
| VPC | `10.0.0.0/16` | Isolated network boundary |
| Public subnet 1 | `10.0.1.0/24`, `eu-west-2a` | Public-facing resources |
| Public subnet 2 | `10.0.2.0/24`, `eu-west-2b` | Additional public subnet |
| Private subnet 1 | `10.0.11.0/24`, `eu-west-2a` | Private workloads |
| Private subnet 2 | `10.0.12.0/24`, `eu-west-2b` | Private workloads |
| NAT Gateway | Public subnet 1 | Outbound connectivity for private subnets |

Both public subnets use a route to the Internet Gateway. Both private subnets use a default route through the NAT Gateway.

**Design note:** one zonal NAT Gateway serves both private subnets. This keeps the lab simpler and cheaper than deploying one NAT Gateway per Availability Zone, but introduces an Availability Zone dependency and possible cross-AZ data-transfer charges.

## Technologies

| Technology | How it is used |
|---|---|
| AWS VPC | Network isolation |
| Public/private subnets | Network segmentation |
| Route tables | Directing network traffic |
| Internet Gateway | Public internet connectivity |
| NAT Gateway | Outbound internet for private subnets |
| Amazon EC2 | Virtual server |
| Amazon Linux 2023 | Server operating system |
| Nginx | HTTP web server |
| Security Groups | Instance-level traffic filtering |
| SSH | Remote Linux administration |
| Amazon CloudWatch | CPU monitoring and alarm evaluation |

## Security configuration

The EC2 security group has these inbound rules:

| Type | Protocol | Port | Source | Reason |
|---|---|---:|---|---|
| SSH | TCP | 22 | Administrator public IP (/32) | Restricted remote administration |
| HTTP | TCP | 80 | `0.0.0.0/0` | Public website access |

SSH is not open to the entire internet. The administrator IP must be updated if it changes. HTTP is public, so the site is currently served without TLS/HTTPS.

## Linux and web server deployment

The server was accessed using SSH and the EC2 key pair. On Amazon Linux 2023:

1. Updated installed packages with `sudo dnf update -y`.
2. Installed Nginx with `sudo dnf install nginx -y`.
3. Enabled and started the service with `sudo systemctl enable --now nginx`.
4. Verified the service with `sudo systemctl status nginx`.
5. Published a custom page in `/usr/share/nginx/html/index.html`.
6. Verified the local HTTP response with `curl -s http://localhost`.

The deployed page is reachable through the EC2 public address over HTTP. Do not publish live IP addresses, account identifiers, private keys or credentials in screenshots or repository files.

## CloudWatch monitoring

CloudWatch was configured to monitor the EC2 `CPUUtilization` metric.

- **Statistic:** Average
- **Evaluation period:** 5 minutes
- **Condition:** Greater than 70%
- **Alarm:** `secure-web-server-high-cpu`

The alarm reached the **OK** state during testing, meaning the evaluated CPU metric was below the configured threshold at that time. No SNS notification or automated recovery action was configured.

## Validation performed

- EC2 instance status checks passed (3/3).
- SSH access to Amazon Linux 2023 succeeded.
- Nginx service reported `active (running)` and `enabled`.
- The custom webpage loaded in a browser over HTTP.
- The CloudWatch CPU metric was visible and the alarm reached OK.

## Repository contents

- `architecture/` — infrastructure architecture diagram and notes.
- `docs/` — implementation and operational notes.
- `scripts/` — reserved for repeatable setup or administration scripts.
- `screenshots/` — project evidence, sanitised before publication.

## Limitations and future improvements

This is a learning project, not a production deployment.

- A single EC2 instance is a single point of failure; no load balancer or Auto Scaling group is configured.
- One NAT Gateway serves private subnets in two Availability Zones.
- The website uses HTTP only; HTTPS/TLS is not configured.
- The CloudWatch alarm has no SNS email notification or automated remediation.
- The EC2 instance is deployed in a public subnet for straightforward access in this lab.

Possible next steps include HTTPS with a domain and certificate, SNS notifications, infrastructure as code, private EC2 placement behind a load balancer, and NAT Gateway per Availability Zone where availability requirements justify the cost.

## Author

Cloud engineering learning project focused on AWS, Linux, networking and monitoring.
