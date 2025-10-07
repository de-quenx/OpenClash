#!/bin/bash
. /usr/share/openclash/uci.sh

set_lock() {
   exec 884>"/tmp/lock/openclash_clash_version.lock" 2>/dev/null
   flock -x 884 2>/dev/null
}
del_lock() {
   flock -u 884 2>/dev/null
   rm -rf "/tmp/lock/openclash_clash_version.lock" 2>/dev/null
}
set_lock

# Get current core versions
get_core_version() {
   local core_type="$1"
   if [ -f "/etc/openclash/core/$core_type" ]; then
      /etc/openclash/core/$core_type -v 2>/dev/null | head -n 1 | awk '{print $2}' | tr -d 'v'
   else
      echo "Not Installed"
   fi
}

CLASH_VER=$(get_core_version "clash")
META_VER=$(get_core_version "clash_meta")
TUN_VER=$(get_core_version "clash_tun")
GAME_VER=$(get_core_version "clash_game")

# Create fake version file with current versions
cat > /tmp/clash_last_version <<EOF
Clash Version: ${CLASH_VER}
Meta Version: ${META_VER}
TUN Version: ${TUN_VER}
Game Version: ${GAME_VER}
EOF

touch -t 203001010000 /tmp/clash_last_version 2>/dev/null
del_lock
exit 0
