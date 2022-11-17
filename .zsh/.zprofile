# Only for login shells
# Set environment, rest is handled either way by desktop and/or other rc files

if systemctl is-system-running --quiet 2> /dev/null; then
  eval $(systemctl --user show-environment)
fi
