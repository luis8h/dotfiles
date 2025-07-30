#!/usr/bin/env -S uv run python

import i3ipc
import subprocess
import os

# Resolve this script's directory (where eww.yuck lives)
CONFIG_DIR = os.path.dirname(os.path.abspath(__file__))

i3 = i3ipc.Connection()
active_bars = {}

def spawn_bar(output):
    if output in active_bars:
        return
    print(f"Spawning bar on {output}")
    proc = subprocess.Popen([
        "eww", "-c", CONFIG_DIR,
        "open", "bar", f"--arg=monitor={output}"
    ])
    active_bars[output] = proc

def kill_bar(output):
    if output in active_bars:
        print(f"Killing bar on {output}")
        subprocess.run([
            "eww", "-c", CONFIG_DIR,
            "close", "bar", f"--arg=monitor={output}"
        ])
        active_bars[output].kill()
        del active_bars[output]

def refresh_bars(_=None, __=None):
    outputs = [o.name for o in i3.get_outputs() if o.active]
    # Spawn bars for new outputs
    for out in outputs:
        spawn_bar(out)
    # Kill bars for disconnected outputs
    for out in list(active_bars.keys()):
        if out not in outputs:
            kill_bar(out)

# Initial setup
refresh_bars()

# Listen for monitor changes
i3.on("output", refresh_bars)
i3.main()

