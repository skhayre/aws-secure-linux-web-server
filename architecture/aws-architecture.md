# AWS Infrastructure Architecture

This diagram represents the AWS infrastructure deployed in the London region (`eu-west-2`).

```mermaid
flowchart TB
    Internet((Internet))
    IGW[Internet Gateway]
    CW[Amazon CloudWatch<br/>CPU Metric and Alarm]

    subgraph VPC["AWS VPC — 10.0.0.0/16"]
        subgraph AZ1["Availability Zone eu-west-2a"]
            subgraph PUB1["Public Subnet 1 — 10.0.1.0/24"]
                EC2["EC2 Instance<br/>Amazon Linux 2023<br/>Nginx Web Server"]
                NAT["NAT Gateway"]
            end
            PRIV1["Private Subnet 1<br/>10.0.11.0/24"]
        end

        subgraph AZ2["Availability Zone eu-west-2b"]
            PUB2["Public Subnet 2<br/>10.0.2.0/24"]
            PRIV2["Private Subnet 2<br/>10.0.12.0/24"]
        end
    end

    Internet <--> IGW
    IGW --> EC2
    IGW --> NAT
    PRIV1 --> NAT
    PRIV2 --> NAT
    EC2 -. CPU metrics .-> CW
```

**Network design notes:**
- Public subnets use the Internet Gateway for internet connectivity.
- Private subnets route outbound internet traffic through the NAT Gateway.
- The NAT Gateway is located in Availability Zone `eu-west-2a`.
- The EC2 web server is deployed in public subnet 1.
- CloudWatch monitors EC2 CPU utilisation.
