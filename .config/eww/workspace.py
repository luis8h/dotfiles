#!/usr/bin/env -S uv run python

import sys
import i3ipc

def main():
    monitor = sys.argv[1] if len(sys.argv) > 1 else None
    if not monitor:
        print("No monitor specified")
        return

    i3 = i3ipc.Connection()
    workspaces = [
        ws.name for ws in i3.get_workspaces()
        if ws.output == monitor
    ]
    print(" ".join(workspaces))

if __name__ == "__main__":
    main()

