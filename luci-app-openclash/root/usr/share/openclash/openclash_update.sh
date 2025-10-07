l#!/bin/bash
. /usr/share/openclash/log.sh
. /usr/share/openclash/uci.sh

set_lock() {
   exec 878>"/tmp/lock/openclash_update.lock" 2>/dev/null
   flock -x 878 2>/dev/null
}
del_lock() {
   flock -u 878 2>/dev/null
   rm -rf "/tmp/lock/openclash_update.lock" 2>/dev/null
}
set_lock

LOG_OUT "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
LOG_OUT "Tip: Automatic update is DISABLED"
LOG_OUT "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
LOG_OUT "Reason: Data quota saving mode enabled"
LOG_OUT "Info: Your current version is up to date"
LOG_OUT "Info: To update manually:"
LOG_OUT "  1. Download .ipk file manually"
LOG_OUT "  2. Upload via web interface"
LOG_OUT "  3. Or use: opkg install /path/to/file.ipk"
LOG_OUT "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

SLOG_CLEAN
del_lock
exit 0
