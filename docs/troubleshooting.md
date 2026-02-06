# Lessons Learned & Troubleshooting (Full Project Timeline)

## VirtualBox & Virtualization
- VirtualBox failed to start the VM due to CPU virtualization (VT-x / AMD-V) being disabled
- Learned how hypervisors depend on hardware virtualization and how to fix BIOS-level issues
- Encountered ISO boot loops when installation media was not removed after OS install

---

## Ubuntu Server Installation
- Learned the difference between Ubuntu Server and minimal installs
- Understood why enabling SSH during install is important for headless servers

---

## Linux Package Management (apt / dpkg)
- `unattended-upgrades` locked the package manager for hours, blocking installations
- Learned why package locks exist and why deleting lock files is dangerous
- Recovered safely using:
  - service management
  - `dpkg --configure -a`
  - controlled reboot and masking problematic services
- System shutdown hung while waiting for unattended-upgrades to stop, requiring a forced VM power-off

---

## Terminal & Shell Behavior
- Terminal entered a broken input state where arrow keys printed `A B C D`
- Commands appeared frozen even though the system was running
- Learned how terminal flow control and interrupts work and how `Ctrl + C` can recover a broken shell state

---

## Docker & Docker Compose
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

## Guacamole & Database Setup
- Learned why Guacamole requires a database backend
- Chose PostgreSQL and learned how container initialization works via environment variables
- Learned how Docker volumes persist database data across restarts

---

## Networking Fundamentals
- Learned the difference between LAN IPs (`192.168.x.x`) and overlay network IPs (`100.x.x.x`)
- Learned why port forwarding increases attack surface
- Understood how overlay networks replace traditional NAT traversal

---

## VNC & Windows Home Constraints
- Learned that Windows Home cannot host RDP sessions
- Used TightVNC as a workaround for full desktop control
- Encountered display issues caused by multi-monitor setups
- Learned how VNC scaling and monitor selection affect stability

---

## Tailscale Integration
- Learned how Tailscale creates a private, encrypted network between devices
- Learned to debug connectivity issues logically:
  - internet connectivity first
  - correct device IP
  - correct service running
- Diagnosed SSH timeouts that were ultimately caused by not being connected to Wi-Fi

---

## SSH Connectivity
- Learned how SSH binds to network interfaces
- Learned how to verify listening ports and firewall behavior
- Implemented SSH access exclusively over Tailscale for security

---

## Security Design Decisions
- No services are exposed to the public internet
- No router port forwarding is used
- Credentials are kept local and excluded from version control
- Access is restricted to authenticated Tailscale devices only