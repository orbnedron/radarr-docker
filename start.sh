#!/usr/bin/env bash
set -e

echo "Radarr settings"
echo "===================="
echo
echo "  Config:     ${CONFIG:=/config}"
echo

# Define variables to use when starting application
CONFIG=${CONFIG:-/config}
XDG_CONFIG_HOME=${CONFIG:-/config}

echo "Starting Radarr..."
mono --debug /opt/radarr/Radarr.exe -nobrowser -data=${CONFIG}
