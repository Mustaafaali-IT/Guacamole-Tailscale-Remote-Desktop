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

## 🎥 Video Demonstration

A short walkthrough showing Docker containers running, Apache Guacamole in the browser, and a successful remote desktop session.

▶️ **Watch the demo:**  
https://github.com/Mustaafaali-IT/Guacamole-Tailscale-Remote-Desktop/releases/tag/v1.0-demo

---

## Project Structure

```
guacamole-tailscale-remote-desktop/
├─ README.md
├─ .gitignore
├─ docker/
│  ├─ docker-compose.yml
│  └─ .env.example
├─ scripts/
│  ├─ start.sh
│  ├─ stop.sh
│  └─ status.sh
├─ docs/
│  ├─ troubleshooting.md
│  └─ setup-note.md
└─ screenshots/
   ├─ guacamole-login.png
   ├─ guacamole-desktop-session.png
   └─ tailscale-connected-devices.png
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
```
powershell
ssh <ubuntu-username>@<vm-tailscale-ip>
```
---

## Project Outcome
This project resulted in a fully functional, secure, and portable remote desktop system that:
- Works anywhere with internet access
- Uses industry-standard tools
- Demonstrates real-world troubleshooting and system design


