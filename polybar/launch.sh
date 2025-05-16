#!/bin/bash

export EMACS_SERVER_FILE=/run/user/1000/emacs/server
export EMACS_SOCKET_NAME=/tmp/emacs0/emacsd
export PATH="$PATH":/usr/local/bin/emacsclient

# Terminate already running bar instances
# killall -q polybar

# If all your bars have ipc enabled, you can also use
polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."

