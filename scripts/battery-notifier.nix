{ pkgs }:

pkgs.writeShellApplication {
  name = "battery-notifier";

  runtimeInputs = with pkgs; [
    bash
    coreutils
    gnugrep
    findutils
    procps
    libnotify
  ];

  text = ''
    set -euo pipefail

    # Configuration
    POLL_INTERVAL=120
    LOW_BAT=15
    MAX_NOTIFICATIONS=3

    # Detect battery automatically
    BAT_PATH="$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -n1)"

    [[ -z "$BAT_PATH" ]] && exit 0

    BAT_STATUS="$BAT_PATH/status"

    # Detect battery metric type
    if [[ -f "$BAT_PATH/charge_full" ]]; then
        BAT_FULL="$BAT_PATH/charge_full"
        BAT_NOW="$BAT_PATH/charge_now"
    elif [[ -f "$BAT_PATH/energy_full" ]]; then
        BAT_FULL="$BAT_PATH/energy_full"
        BAT_NOW="$BAT_PATH/energy_now"
    else
        exit 1
    fi

    # Kill previous instances
    kill_running() {
        local current_pid=$$

        mapfile -t pids < <(pgrep -fx "$0")

        for pid in "''${pids[@]}"; do
            [[ "$pid" != "$current_pid" ]] && kill "$pid"
        done
    }

    kill_running

    notifications_sent=0

    while true; do
        full=$(<"$BAT_FULL")
        now=$(<"$BAT_NOW")
        status=$(<"$BAT_STATUS")

        battery_percent=$((100 * now / full))

        if (( battery_percent < LOW_BAT )) &&
           [[ "$status" == "Discharging" ]] &&
           (( notifications_sent < MAX_NOTIFICATIONS )); then

            notify-send \
                --urgency=critical \
                "Low Battery" \
                "$battery_percent% remaining"

            ((notifications_sent++))

        elif [[ "$status" == "Charging" ]]; then
            notifications_sent=0
        fi

        sleep "$POLL_INTERVAL"
    done
  '';
}
