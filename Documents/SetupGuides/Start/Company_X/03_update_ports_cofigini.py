import socket
import configparser

CONFIG_FILE = "config.ini"  # Path to config.ini file

def find_free_port():
    """Find an available free port dynamically."""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("", 0))  # Bind to an available port
        return s.getsockname()[1]  # Return assigned port

def get_system_ip():
    """Retrieve the system's IP address."""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip_address = s.getsockname()[0]
        s.close()
        return ip_address
    except Exception:
        return "127.0.0.1"  # Default to localhost if error

def update_config():
    """Read config.ini, assign dynamic ports, and update values."""
    # Ensure configparser preserves case
    config = configparser.ConfigParser()
    config.optionxform = str  # Preserve case of keys
    config.read(CONFIG_FILE, encoding="utf-8")

    # Fetch instance count and generate database ports
    instances_count = int(config["database"].get("instances", 1))
    db_ports = [str(find_free_port()) for _ in range(instances_count + 1)]  # Need instances + 1 ports
    db_ports_str = ",".join(db_ports)

    # Assign other ports
    api_port = str(find_free_port())
    web_port = str(find_free_port())
    smtp_port = str(find_free_port())

    # Get system IP address
    system_ip = get_system_ip()

    # Update config values
    config["database"]["ports"] = db_ports_str
    config["database"]["DB_SERVER_HOST_IP"] = system_ip
    config["AppService"]["APP_SERVER_HOST"] = system_ip
    config["AppService"]["APP_SERVER_PORT"] = api_port
    config["WebClient"]["WEB_CLIENT_PORT"] = web_port
    config["SMTP"]["SMTP_HOST"] = system_ip
    config["SMTP"]["SMTP_PORT"] = smtp_port

    # Write back without adding spaces around '='
    with open(CONFIG_FILE, "w", encoding="utf-8") as configfile:
        config.write(configfile, space_around_delimiters=False)

    print("Updated config.ini successfully!")

if __name__ == "__main__":
    update_config()
