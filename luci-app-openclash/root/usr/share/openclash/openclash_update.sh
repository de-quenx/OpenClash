#!/bin/bash
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

LOG_OUT "Tip: Automatic update is disabled to save data quota"
LOG_OUT "Info: Please update manually if needed"
SLOG_CLEAN

del_lock
exit 0
