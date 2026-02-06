# Secure Remote Desktop with Guacamole, Tailscale, and SSH (Windows Home)

## Overview
This project provides secure, browser-based remote access to a Windows desktop from anywhere in the world without exposing ports to the public internet.

The solution combines:
- **Apache Guacamole** for browser-based remote desktop access
- **VNC (TightVNC)** because Windows Home cannot host RDP
- **Tailscale** for encrypted, private networking
- **SSH** for secure administration of the Linux server

This was built as a real-world IT project focused on virtualization, Linux administration, Docker, networking, and troubleshooting real failures.

---

## Project Structure
```
guacamole-tailscale-remote-desktop/
├── README.md
├── .gitignore
├── docker/
│   ├── docker-compose.yml
│   └── guacamole/
├── screenshots/
│   ├── guacamole-login.png
│   ├── vnc-desktop.png
│   └── tailscale-status.png
└── notes/
    └── troubleshooting.md
```
---

## Architecture
Laptop (anywhere)  
→ Tailscale (encrypted private network)  
→ Ubuntu Server VM (Docker + Guacamole)  
→ VNC  
→ Windows Desktop (TightVNC Server)

Administrative access:  
Laptop → Tailscale → SSH → Ubuntu Server VM

---

## Why I Built This
I wanted a remote desktop solution that:
- Works reliably while traveling
- Does not rely on time-limited third-party tools
- Does not require Windows Pro
- Does not expose router ports to the internet

At the same time, I wanted a portfolio-grade project that forced me to solve real infrastructure and networking problems rather than follow a simple tutorial.

---

## Technologies Used
- Windows Desktop (host machine)
- VirtualBox
- Ubuntu Server (VM)
- Docker
- Docker Compose
- Apache Guacamole
- PostgreSQL
- TightVNC Server
- Tailscale
- OpenSSH

---

## High-Level Setup Flow
1. Create an Ubuntu Server VM in VirtualBox
2. Resolve virtualization issues (VT-x / hypervisor errors)
3. Install Docker and Docker Compose
4. Deploy Guacamole and PostgreSQL using Docker Compose
5. Install TightVNC Server on Windows desktop
6. Install Tailscale on:
   - Windows desktop
   - Laptop
   - Ubuntu VM
7. Configure Guacamole VNC connections using:
   - Local LAN IP for home access
   - Tailscale IP for remote access
8. Enable SSH access to the Ubuntu VM over Tailscale

---

## SSH Usage
SSH is used for secure remote administration of the Ubuntu server.

Example from the laptop:

powershell
ssh <ubuntu-username>@<vm-tailscale-ip>

---

## Lessons Learned & Troubleshooting (Full Project Timeline)

### VirtualBox & Virtualization
- VirtualBox failed to start the VM due to CPU virtualization (VT-x / AMD-V) being disabled
- Learned how hypervisors depend on hardware virtualization and how to fix BIOS-level issues
- Encountered ISO boot loops when installation media was not removed after OS install

---

### Ubuntu Server Installation
- Learned the difference between Ubuntu Server and minimal installs
- Understood why enabling SSH during install is important for headless servers

---

### Linux Package Management (apt / dpkg)
- `unattended-upgrades` locked the package manager for hours, blocking installations
- Learned why package locks exist and why deleting lock files is dangerous
- Recovered safely using:
  - service management
  - `dpkg --configure -a`
  - controlled reboot and masking problematic services
- System shutdown hung while waiting for unattended-upgrades to stop, requiring a forced VM power-off

---

### Terminal & Shell Behavior
- Terminal entered a broken input state where arrow keys printed `A B C D`
- Commands appeared frozen even though the system was running
- Learned how terminal flow control and interrupts work and how `Ctrl + C` can recover a broken shell state

---

### Docker & Docker Compose
- Learned how containers differ from full virtual machines
- Learned Docker installation flags and permission management
- Understood Docker Compose structure:
  - services
  - images
  - ports
  - environment variables
  - volumes
  - restart policies
- Learned why pinning image versions prevents unexpected breakage

---

### Guacamole & Database Setup
- Learned why Guacamole requires a database backend
- Chose PostgreSQL and learned how container initialization works via environment variables
- Learned how Docker volumes persist database data across restarts

---

### Networking Fundamentals
- Learned the difference between LAN IPs (`192.168.x.x`) and overlay network IPs (`100.x.x.x`)
- Learned why port forwarding increases attack surface
- Understood how overlay networks replace traditional NAT traversal

---

### VNC & Windows Home Constraints
- Learned that Windows Home cannot host RDP sessions
- Used TightVNC as a workaround for full desktop control
- Encountered display issues caused by multi-monitor setups
- Learned how VNC scaling and monitor selection affect stability

---

### Tailscale Integration
- Learned how Tailscale creates a private, encrypted network between devices
- Learned to debug connectivity issues logically:
  - internet connectivity first
  - correct device IP
  - correct service running
- Diagnosed SSH timeouts that were ultimately caused by not being connected to Wi-Fi

---

### SSH Connectivity
- Learned how SSH binds to network interfaces
- Learned how to verify listening ports and firewall behavior
- Implemented SSH access exclusively over Tailscale for security

---

### Security Design Decisions
- No services are exposed to the public internet
- No router port forwarding is used
- Credentials are kept local and excluded from version control
- Access is restricted to authenticated Tailscale devices only

---

## Project Outcome
This project resulted in a fully functional, secure, and portable remote desktop system that:
- Works anywhere with internet access
- Uses industry-standard tools
- Demonstrates real-world troubleshooting and system design


