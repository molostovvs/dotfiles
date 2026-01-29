#!/usr/bin/env python3
import urllib.request
import json

# Configuration
# Using ipwho.is as it supports HTTPS and is free.
API_URL = "https://ipwho.is/"

def main():
    try:
        # Set a timeout to avoid hanging the bar
        req = urllib.request.Request(API_URL, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=10) as url:
            data = json.loads(url.read().decode())
            
            if not data.get("success", False):
                 raise Exception(data.get("message", "API Error"))

            country_code = data.get("country_code", "Unknown")
            country_name = data.get("country", "Unknown")
            ip = data.get("ip", "Unknown")
            isp = data.get("connection", {}).get("isp", "Unknown")
            
            # Logic: If country is NOT Russia (RU), assume VPN is active.
            if country_code != "RU":
                status_text = "VPN: ON"
                css_class = "connected"
                icon = "" # Lock icon
                tooltip_format = f"Status: {status_text}\nIP: {ip}\nCountry: {country_name}\nISP: {isp}\n\n<i>VPN Active</i>"
            else:
                status_text = "VPN: OFF"
                css_class = "disconnected"
                icon = "" # Unlock icon
                tooltip_format = f"Status: {status_text}\nIP: {ip}\nCountry: {country_name}\nISP: {isp}\n\n<i>VPN Inactive</i>"

            # Waybar JSON output
            output = {
                "text": f"{icon} {country_code}",
                "alt": status_text,
                "tooltip": tooltip_format,
                "class": css_class,
                "percentage": 100 if css_class == "connected" else 0
            }
            
            print(json.dumps(output))
            
    except Exception as e:
        # On error (no internet, timeout), output a neutral state
        print(json.dumps({
            "text": "VPN: ?",
            "tooltip": f"Error checking status: {str(e)}",
            "class": "error"
        }))

if __name__ == "__main__":
    main()
