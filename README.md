# CloudWatcher

**Personal Ubuntu server hosted on Linode for web development and website hosting with secure remote access and enterprise-style hardening.**

---

## Overview

CloudWatcher is a manually configured Ubuntu 22.04 server hosted on Linode. It serves my personal website and development projects while prioritizing security, controlled access, and reliable backups. The server demonstrates hands-on experience with Linux server administration, networking, VPNs, and secure system configuration.

---

## Features

- Secure remote access via WireGuard VPN and SSH keys for a dedicated non-root user  
- Manual Ubuntu hardening: firewall rules, non-root SSH, restricted access  
- Nginx web server hosting for personal website and development projects  
- Automated backups:
  - Linode snapshots
  - Object storage backup (Linode bucket)
- Persistent logging and monitoring for system, service, and network events  
- Infrastructure maintained entirely through manual configuration for full control
- Domain and DNS managed via AWS Route53
- HTTPS configured with AWS Certificate Manager
- Custom domain email setup using Zoho Mail with catch-all support
---

## Architecture Diagram

## Architecture Diagram

The following diagram shows the CloudWatcher server setup:

- Secure remote access via WireGuard VPN and SSH keys
- Nginx web server with HTTPS via AWS Certificate Manager
- DNS managed via AWS Route53
- Email handled via Zoho Mail with catch-all functionality
- Persistent logging and backup flows illustrated

```mermaid
flowchart TD
    Internet((Internet))
    Route53[AWS Route53 DNS]
    ACM[AWS Certificate Manager (HTTPS)]
    CloudWatcher[CloudWatcher Server (Ubuntu 24.04.4)]
    Nginx[Nginx Web Server]
    VPN[WireGuard VPN]
    Users[Authorized Users (SSH Keys)]
    UFW[UFW Firewall + Fail2Ban]
    Logs[Persistent Logging (journald, Nginx, UFW)]
    Backups[Backups (Linode Snapshots & Object Storage)]
    Email[Zoho Mail (catch-all @infosecmatthew.com)]

    Internet --> Route53
    Route53 --> ACM
    ACM --> CloudWatcher
    CloudWatcher --> Nginx
    CloudWatcher --> VPN
    VPN --> Users
    CloudWatcher --> UFW
    CloudWatcher --> Logs
    CloudWatcher --> Backups
    Route53 --> Email

---

## Security & Hardening

### Access & Authentication
- SSH access restricted to a non-root user  
- Root login disabled  
- Password authentication disabled; SSH keys required  
- User logins limited via `AllowUsers` in SSH configuration  

### Firewall & Network
- UFW configured to deny all incoming traffic except:  
  - SSH (custom port)  
  - WireGuard VPN  
  - HTTPS (Nginx)  
- Fail2Ban installed to prevent brute-force login attempts  
- Unused services disabled to minimize attack surface  

### Logging & Monitoring
- Persistent system logging enabled with `journald` for OS and service events  
- Nginx access and error logs maintained for web server monitoring  
- UFW firewall logs maintained for network activity auditing  
- SSH and sudo activity logged in `/var/log/auth.log`  

### Updates & Maintenance
- Automatic security updates enabled for timely vulnerability patching  
- Regular Linode snapshots and object storage backups ensure data redundancy  

### VPN
- WireGuard VPN configured as the only remote access method to the server  
- VPN enforces strong encryption and restricted allowed IPs  

---

## Setup Summary (Reproducible Steps)

> Note: Sensitive credentials, IPs, and keys are not included for security reasons.

1. Install Ubuntu 22.04 LTS on a Linode VM  
2. Create dedicated non-root user for SSH access  
3. Configure WireGuard VPN for all remote connections  
4. Install and configure Nginx for web hosting  
5. Enable UFW firewall and configure rules for required services  
6. Install Fail2Ban to protect against brute-force attacks  
7. Enable persistent journald logging and verify system logs  
8. Configure Linode snapshot backups and object storage backups  
9. Enable automatic security updates  
10. Configured Route53 DNS and AWS Certificate Manager for secure HTTPS traffic
11. Integrated custom email via Zoho Mail with catch-all functionality for personal domain

---

## Notes

All services and hardening measures were configured manually to demonstrate a deep understanding of Linux server security, networking, and operational reliability.

---

## License

*(Optional: add MIT or other license for open-source configs.)*