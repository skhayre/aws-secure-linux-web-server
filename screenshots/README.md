# AWS Secure Linux Web Server – Project Evidence

This folder contains 13 screenshots documenting the architecture, deployment, configuration and monitoring of the AWS Secure Linux Web Server project.

## Project evidence

| No. | Filename | Description |
|---:|---|---|
| 1 | `01-vpc-created.png` | VPC configuration and CIDR range |
| 2 | `02-vpc-resource-map.png` | VPC resource architecture |
| 3 | `03-public-private-subnet-associations.png` | Public and private subnet configuration |
| 4 | `04-nat-gateway-available.png` | NAT Gateway configuration |
| 5 | `05-route-tables-overview.png` | Route table configuration |
| 6 | `06-private-route-to-nat-gateway.png` | Private subnet routing through NAT Gateway |
| 7 | `07-public-route-to-internet-gateway.png` | Public subnet routing through Internet Gateway |
| 8 | `08-ec2-instance-running.png` | EC2 instance running and passing status checks |
| 9 | `09-ec2-connect-ssh-method.png` | EC2 connection configuration |
| 10 | `10-ssh-linux-session.png` | Successful SSH connection to Amazon Linux 2023 |
| 11 | `11-nginx-service-and-terminal.png` | Nginx installation and service configuration |
| 12 | `12-cloudwatch-cpu-alarm-ok.png` | CloudWatch CPU monitoring and alarm in OK state |
| 13 | `13-nginx-custom-webpage.png` | Live custom webpage hosted on the EC2 instance |

## Security and redaction

Screenshots have been reviewed and sanitised before publication.

- AWS account identifiers and sensitive resource identifiers have been redacted.
- Personal and infrastructure IP addresses have been removed where appropriate.
- No private keys, passwords, access keys or authentication tokens are included.
- The EC2 private key (`.pem`) is kept private and is not stored in this repository.

## Notes

The live webpage is currently served over HTTP. HTTPS has not yet been configured.

This project is an educational cloud engineering lab and is not intended to represent a fully production-ready, highly available architecture.
