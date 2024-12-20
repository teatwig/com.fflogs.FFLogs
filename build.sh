#!/bin/sh
flatpak run org.flatpak.Builder --force-clean --sandbox --user --install --install-deps-from=flathub-user builddir com.fflogs.FFLogs.yaml
