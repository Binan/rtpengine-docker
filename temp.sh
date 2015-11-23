#! /bin/sh

INTERFACES=`ls -1 /sys/class/net`
  if test "$INTERFACES" = "" ; then
    echo "No network interfaces found" >&2
    exit 1
  fi

  for INTERFACE in $INTERFACES
  do
    SYSTIP=`/sbin/ip -4 -o addr show dev $INTERFACE | awk '{split($4,a,"/");print a[1]}'| head -1`
    echo "Found system interface $INTERFACE ip address $SYSTIP" 
    
  done
