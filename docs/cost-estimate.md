# AWS Cost Estimate — VPC Infrastructure

Estimated monthly cost for a two-AZ deployment in `us-east-1`. Based on April 2025 AWS pricing.

> **Note**: This is a lab environment. Production costs will scale with actual usage (data transfer, instance hours, etc.)

## Fixed Costs (Always Running)

| Resource | Qty | Unit Cost | Monthly |
|---|---|---|---|
| NAT Gateway (per AZ) | 2 | $32.40/AZ | $64.80 |
| VPC (free tier) | 1 | $0 | $0 |
| Internet Gateway | 1 | $0 | $0 |
| Subnets (6 total) | 6 | $0 | $0 |
| Route Tables | 4 | $0 | $0 |
| VPC Endpoints (S3, SSM) | 2 | $0 (gateway type) | $0 |
| **Fixed subtotal** | | | **$64.80** |

## Variable Costs (Traffic-Based)

| Resource | Rate | Notes |
|---|---|---|
| NAT Gateway data processing | $0.045/GB | Per GB through NAT |
| Cross-AZ data transfer | $0.01/GB | Between AZs within same region |
| S3 via VPC Endpoint | $0 | Free via gateway endpoint |

## Example: Light Dev Workload (100GB/month through NAT)

```
NAT Gateway (2 AZ)          = $64.80
NAT data (100 GB × $0.045)  = $4.50
Cross-AZ (~10 GB × $0.01)   = $0.10
Total                       = ~$69.40/month
```

## Cost Optimization Tips Implemented

1. **Gateway VPC Endpoints** for S3 and SSM — free, saves all S3 traffic going through NAT
2. **Separate public/private/isolated subnets** — only public resources need Elastic IPs
3. **No Elastic IPs** allocated unless bound to a specific resource — EIPs cost $0.005/hr unattached

## Teardown Reminder

After testing, always destroy to avoid idle NAT Gateway charges:

```bash
terraform destroy -auto-approve
```

Unattached resources after `terraform destroy`:
- Verify no orphaned EIPs in the console (`aws ec2 describe-addresses`)
- Verify no residual NAT Gateways stuck in `deleting` state

## Cost vs t2.micro Comparison

Running the lab for 8 hours/day, 5 days/week:
```
NAT hours = 8h × 5 × 4 weeks = 160h/month
160h × $0.045 (NAT hr rate) = $7.20/month
Much cheaper than running instances continuously
```
