#!/usr/bin/python3
# RAM in use (%), read from /proc/meminfo. Stdlib only (no psutil).
# Same formula as psutil.virtual_memory().percent: (MemTotal - MemAvailable) / MemTotal.
try:
    mem = {}
    with open("/proc/meminfo") as f:
        for line in f:
            key, value = line.split(":", 1)
            mem[key] = int(value.split()[0])
    total, avail = mem["MemTotal"], mem["MemAvailable"]
    print(f"{100.0 * (total - avail) / total:.1f}")
except (OSError, ValueError, KeyError, ZeroDivisionError):
    print("NaN")
