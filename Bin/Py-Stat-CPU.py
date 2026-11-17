#!/usr/bin/python3
# CPU utilisation (%) over a 0.1s sample, read from /proc/stat. Stdlib only (no psutil).
import time


def snapshot():
    with open("/proc/stat") as f:
        fields = [int(x) for x in f.readline().split()[1:]]
    idle = fields[3] + (fields[4] if len(fields) > 4 else 0)  # idle + iowait
    return idle, sum(fields)


try:
    idle1, total1 = snapshot()
    time.sleep(0.1)
    idle2, total2 = snapshot()
    delta = total2 - total1
    print(f"{100.0 * (delta - (idle2 - idle1)) / delta:.1f}" if delta else "0.0")
except (OSError, ValueError, IndexError):
    print("NaN")
