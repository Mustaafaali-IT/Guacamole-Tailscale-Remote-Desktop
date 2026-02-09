## Database Initialization

This project does **not** include a pre-seeded database or exported Guacamole connections.

On first startup, Apache Guacamole automatically initializes a fresh PostgreSQL database and prompts the user to create an administrator account via the web interface.

This approach reflects a real-world deployment where:
- Credentials are created at runtime
- No sensitive data is committed to version control
- Configuration is handled through environment variables and Docker volumes