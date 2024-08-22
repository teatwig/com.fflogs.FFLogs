#!/usr/bin/env bash

export TMPDIR="$XDG_RUNTIME_DIR/app/${FLATPAK_ID:-com.fflogs.FFLogs}"

declare -a FLAGS=(--enable-speech-dispatcher)

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    if [[ -c /dev/nvidia0 ]]; then
        echo "Using NVIDIA on Wayland, disabling gpu sandbox"
        FLAGS+=(--disable-gpu-sandbox)
    fi

    WAYLAND_SOCKET=${WAYLAND_DISPLAY:-"wayland-0"}
    if [[ "${WAYLAND_SOCKET:0:1}" != "/" ]]; then
        WAYLAND_SOCKET="$XDG_RUNTIME_DIR/$WAYLAND_SOCKET"
    fi

    if [[ -e "$WAYLAND_SOCKET" ]]; then
        echo "Wayland socket is available, running natively on Wayland."
        echo "To disable, remove the --socket=wayland permission."
        FLAGS+=(--ozone-platform-hint=auto)
    fi
fi

echo "Passing the following arguments to Electron:" "${FLAGS[@]}"
zypak-wrapper /app/fflogs/fflogs "${FLAGS[@]}" "$@"
