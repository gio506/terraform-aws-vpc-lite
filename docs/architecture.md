# Terraform AWS VPC Architecture

## What This Builds

A three-subnet VPC for a typical web application: public subnet for load balancers, private subnet for application servers, and an isolated subnet for databases.

```text
VPC (10.0.0.0/16)
├── us-east-1a
│   ├── public-1a    (10.0.1.0/24)  ← ALB, NAT Gateway
│   ├── private-1a   (10.0.10.0/24) ← App servers, ECS tasks
│   └── isolated-1a  (10.0.20.0/24) ← RDS, ElastiCache
└── us-east-1b
    ├── public-1b    (10.0.2.0/24)
    ├── private-1b   (10.0.11.0/24)
    └── isolated-1b  (10.0.21.0/24)
```

---

## Key Design Decisions

### Why /16 for the VPC?

65,536 IPs is intentionally large. We use /24 subnets which gives 256 usable IPs per subnet — enough for dozens of running instances per AZ. Leaving the upper range free allows adding new subnet tiers (e.g., a separate management subnet) without re-IP-ing.

### Why three tiers?

Security posture:
- **Public**: Only load balancers go here. Security group allows 80/443 from internet.
- **Private**: App servers. Gets internet access via NAT Gateway, but no public IPs. Reduces blast radius if an app is compromised.
- **Isolated**: No internet access at all. No route to NAT, no internet gateway route. Database traffic stays inside the VPC.

### NAT Gateway vs NAT Instance

This design uses a managed NAT Gateway per AZ (more reliable, no maintenance). In a cost-sensitive environment, a single NAT Gateway in one AZ would work at the cost of cross-AZ traffic charges.

---

## Module Structure

```text
modules/
├── vpc/          Core VPC, subnets, route tables
├── security/     Security groups per tier
└── endpoints/    VPC endpoints for S3, SSM (avoids NAT costs)
```

### Why VPC Endpoints?

S3 and SSM traffic do NOT need to go through the NAT Gateway. A VPC endpoint creates a private path within the AWS network — reducing NAT costs and keeping traffic off the internet.

---

## Security Group Rules

### Public SG
- Inbound: 80 from 0.0.0.0/0, 443 from 0.0.0.0/0
- Outbound: All traffic (to reach private SG)

### Private SG
- Inbound: 8080 from public SG only (no direct internet)
- Outbound: 443 to 0.0.0.0/0 (via NAT for package downloads), 5432 to isolated SG

### Isolated SG
- Inbound: 5432 from private SG only
- Outbound: None (no egress rules unless explicitly needed)
