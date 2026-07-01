# Terraform Azure Networking and VM Deployment Exercise

This exercise was completed after finishing the following Microsoft Learn learning path:

https://learn.microsoft.com/en-us/training/paths/az-104-manage-virtual-networks/
and
https://learn.microsoft.com/en-us/training/paths/az-104-manage-compute-resources/

## Architecture Overview

```text
Internet
    │
    ▼
Public IP
    ▼
Web VM (Nginx)
    │
    ▼
App VM

VNet
10.0.0.0/16

├── WebSubnet
│   10.0.1.0/24
│
│   Web NSG
│
│   Route Table
│     Destination: 0.0.0.0/0
│     Next Hop: 10.0.10.4 (Firewall)
│
│   Web VM
│   Nginx
│
├── AppSubnet
│   10.0.2.0/24
│
│   App NSG
│
│   App VM
│
├── DBSubnet
│   10.0.3.0/24
│
│   DB NSG
│
│   DB VM(planned, but not practiced because of my free subscription)
│
└── FirewallSubnet
    10.0.10.0/24
```

## Traffic Flow

```text
Internet
    ↓
80 / 443
    ↓
Web
    ↓
8080
    ↓
Application
    ↓
1433
    ↓
Database
```

## Resources Created

### Resource Group

```text
rg-tf-network-exe
```

### Virtual Network

```text
vnet-tf-learning
```

Address Space:

```text
10.0.0.0/16
```

Subnets:

| Subnet | Address Range |
|---------|---------|
| WebSubnet | 10.0.1.0/24 |
| AppSubnet | 10.0.2.0/24 |
| DBSubnet | 10.0.3.0/24 |
| FirewallSubnet | 10.0.10.0/24 |

## Virtual Machines

### Web VM

- Ubuntu 22.04 LTS
- Public IP attached
- Accessible through SSH
- Nginx installed

### App VM

- Ubuntu 22.04 LTS
- Private IP only
- Deployed into AppSubnet

## Network Security Groups

### Web NSG

- Allow HTTP (80) from the Internet
- Allow HTTPS (443) from the Internet
- Deny SSH (22) from the Internet

### App NSG

- Allow TCP 8080 from WebSubnet only
- Deny inbound traffic from the Internet

### DB NSG

- Allow TCP 1433 from AppSubnet only
- Deny inbound traffic from the Internet

## Route Table

### Route Table

```text
rt-web-to-firewall
```

### Route Configuration

| Destination | Next Hop Type | Next Hop IP |
|------------|------------|------------|
| 0.0.0.0/0 | Virtual Appliance | 10.0.10.4 |

## What I Practiced

- Creating Azure networking resources with Terraform
- Creating VNets and subnets
- Associating NSGs with subnets
- Creating NSG rules
- Creating Linux virtual machines
- Creating Public IPs and NICs
- Connecting to Azure VMs using SSH
- Installing and validating Nginx
- Understanding the difference between destinations and next hops
- Understanding how NSGs and route tables affect workload traffic

## Limitations

The DB subnet and NSG were created as part of the design, but the DB VM was not deployed due to Azure free subscription regional core quota limits.