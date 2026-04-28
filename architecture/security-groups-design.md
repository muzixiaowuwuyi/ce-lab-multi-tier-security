# Security Groups Design Decisions

## 1. Design Philosophy
This project implements a **Multi-Tier Security Architecture** based on the principle of **Least Privilege**. The core strategy is to isolate each functional layer of the application and only permit necessary traffic.

## 2. Security Group Specifications

### CE-Bastion-SG (Management Tier)
- **Role:** Acts as a hardened jump host (Bastion) for all administrative access.
- **Inbound:** Restricts SSH (Port 22) to my specific **Public IP address** only.
- **Outbound:** Restricted to internal Security Groups for SSH access, minimizing the blast radius if compromised.

### CE-Web-SG (Web Tier)
- **Role:** Public-facing layer receiving end-user traffic.
- **Inbound:** - Allows HTTP (80) and HTTPS (443) from `0.0.0.0/0`.
  - Allows SSH (22) **only from CE-Bastion-SG**.
- **Outbound:** Permits traffic to the App Tier on port 8080 and HTTPS (443) to the internet for OS patching.

### CE-App-SG (Application Tier)
- **Role:** Handles business logic in a private subnet.
- **Inbound:** - Allows Custom TCP (8080) **only from CE-Web-SG**.
  - Allows SSH (22) **only from CE-Bastion-SG**.
- **Outbound:** Restricts traffic to the Database Tier on port 3306.

### CE-DB-SG (Database Tier)
- **Role:** Stores sensitive data, highly isolated.
- **Inbound:** - Allows MySQL (3306) **only from CE-App-SG**.
  - Allows SSH (22) **only from CE-Bastion-SG**.
- **Outbound:** Strictly limited; only HTTPS (443) for essential security updates.

## 3. Key Technical Feature: SG Referencing
Instead of using static IP addresses (CIDR blocks) for internal communication, this design uses **Security Group Referencing**. 
- **Benefit:** If we scale out the Web or App tiers, new instances automatically inherit the correct permissions without manual rule updates.
- **Security:** It ensures that even if an IP is spoofed, traffic is only accepted from verified members of the trusted Security Group.