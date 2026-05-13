#!/usr/bin/env bash
# idle_mode.sh — control and query Hyprland's idle behaviour (lock / screen-off / suspend)
#
# Modes:
#   normal      idle handling exactly as configured in hypridle.conf
#   no_suspend  lock + screen-off still happen on schedule, suspend is blocked
#   full        nothing happens at all — lock, screen-off and suspend are all blocked
#
# State lives under $XDG_RUNTIME_DIR (tmpfs), so it always resets to "normal"
# on reboot/login rather than risking the PC staying awake forever because a
# mode was left on.
#
# Usage:
#   idle_mode.sh status                 -> JSON for waybar's custom module
#   idle_mode.sh cycle                  -> normal -> no_suspend -> full -> normal
#   idle_mode.sh set <mode>             -> jump straight to a mode
#   idle_mode.sh gate <lock|screen|suspend>  -> exit 0 = allowed, exit 1 = blocked
#                                              (used from hypridle.conf on-timeout lines)

set -euo pipefail

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}"
STATE_FILE="$STATE_DIR/hypr_idle_mode"
WAYBAR_SIGNAL=8   # must match "signal" in waybar's custom/idle_mode module

MODES=(normal no_suspend full)

current_mode() {
    if [[ -f "$STATE_FILE" ]]; then
        cat "$STATE_FILE"
    else
        echo "normal"
    fi
}

# Atomic write: write to a tmpfile then rename, so a concurrent read never
# sees a half-written state file.
write_mode() {
    local mode="$1"
    local tmp
    tmp="$(mktemp "$STATE_DIR/.hypr_idle_mode.XXXXXX")"
    printf '%s' "$mode" > "$tmp"
    mv -f "$tmp" "$STATE_FILE"
}

notify_mode() {
    local mode="$1"
    command -v notify-send >/dev/null 2>&1 || return 0
    case "$mode" in
        normal)
            notify-send -t 2000 -a "idle-mode" "Idle: normal" \
                "Lock, screen-off and suspend all work as usual." || true ;;
        no_suspend)
            notify-send -t 2000 -a "idle-mode" "Idle: no auto-suspend" \
                "Screen still locks/turns off on schedule. The PC will not suspend." || true ;;
        full)
            notify-send -t 2000 -a "idle-mode" "Idle: fully awake" \
                "Lock, screen-off and suspend are all disabled." || true ;;
    esac
}

ping_waybar() {
    pkill -RTMIN+"$WAYBAR_SIGNAL" waybar 2>/dev/null || true
}

cmd_cycle() {
    local cur next
    cur="$(current_mode)"
    case "$cur" in
        normal)     next=no_suspend ;;
        no_suspend) next=full ;;
        full)       next=normal ;;
        *)          next=normal ;;
    esac
    write_mode "$next"
    notify_mode "$next"
    ping_waybar
}

cmd_set() {
    local mode="${1:-}"
    for m in "${MODES[@]}"; do
        if [[ "$m" == "$mode" ]]; then
            write_mode "$mode"
            notify_mode "$mode"
            ping_waybar
            return 0
        fi
    done
    echo "idle_mode.sh: unknown mode '$mode' (expected: ${MODES[*]})" >&2
    exit 1
}

cmd_status() {
    local mode text class tooltip
    mode="$(current_mode)"
    case "$mode" in
        normal)
            text=""
            class="normal"
            tooltip="Idle: normal\nClick to disable auto-suspend"
            ;;
        no_suspend)
            text=" no-suspend"
            class="no-suspend"
            tooltip="Idle: no auto-suspend\nScreen still locks/turns off, PC stays on.\nClick to go fully awake."
            ;;
        full)
            text=" awake"
            class="full"
            tooltip="Idle: fully awake\nLock, screen-off and suspend are all disabled.\nClick to go back to normal."
            ;;
    esac
    printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$text" "$class" "$tooltip"
}

cmd_gate() {
    local target="${1:-}"
    local mode
    mode="$(current_mode)"
    case "$mode" in
        normal)
            exit 0 ;;
        no_suspend)
            [[ "$target" == "suspend" ]] && exit 1
            exit 0 ;;
        full)
            exit 1 ;;
        *)
            exit 0 ;;
    esac
}

case "${1:-}" in
    cycle)  cmd_cycle ;;
    set)    cmd_set "${2:-}" ;;
    status) cmd_status ;;
    gate)   cmd_gate "${2:-}" ;;
    *)
        echo "usage: $(basename "$0") {cycle|set <mode>|status|gate <lock|screen|suspend>}" >&2
        exit 1
        ;;
esac
