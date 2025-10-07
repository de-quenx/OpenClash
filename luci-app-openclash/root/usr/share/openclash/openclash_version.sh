#!/bin/bash
. /usr/share/openclash/uci.sh

set_lock() {
   exec 869>"/tmp/lock/openclash_version.lock" 2>/dev/null
   flock -x 869 2>/dev/null
}
del_lock() {
   flock -u 869 2>/dev/null
   rm -rf "/tmp/lock/openclash_version.lock" 2>/dev/null
}
set_lock

# Get current version
if [ -x "/bin/opkg" ]; then
   OP_CV=$(rm -f /var/lock/opkg.lock && opkg status luci-app-openclash 2>/dev/null |grep 'Version' |awk -F 'Version: ' '{print $2}')
elif [ -x "/usr/bin/apk" ]; then
   OP_CV=$(apk list luci-app-openclash 2>/dev/null|grep 'installed' | grep -oE '[0-9]+(\.[0-9]+)*' | head -1)
fi

# Create fake version file with current version (no update available)
if [ -n "$OP_CV" ]; then
   echo "v${OP_CV}" > /tmp/openclash_last_version
else
   echo "v0.0.0" > /tmp/openclash_last_version
fi

touch -t 203001010000 /tmp/openclash_last_version 2>/dev/null
del_lock
exit 0
