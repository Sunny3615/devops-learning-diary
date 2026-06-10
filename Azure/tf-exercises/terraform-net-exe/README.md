# Terraform Azure Networking Exercise

This exercise was completed after finishing the following Microsoft Learn learning path:

https://learn.microsoft.com/en-us/training/paths/az-104-manage-virtual-networks/

## Architecture Overview

```text
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
├── AppSubnet
│   10.0.2.0/24
│
│   App NSG
│
├── DBSubnet
│   10.0.3.0/24
│
│   DB NSG
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
- Creating and associating route tables
- Understanding the difference between destinations and next hops
- Using a User Defined Route (UDR) to direct traffic through a firewall