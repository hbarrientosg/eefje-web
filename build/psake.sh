#!/bin/bash

case "$1" in
   -h)
     powershell -NoProfile -ExecutionPolicy Bypass -Command "$(dirname $0)\psake.ps1 -help"
     ;;
   *)
   powershell -NoProfile -ExecutionPolicy Bypass -Command "& $(dirname $0)\psake.ps1 $*; if (\$psake.build_success -eq \$false) { exit 1 } else { exit 0 }"
esac
