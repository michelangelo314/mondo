#!/bin/sh

exec /sbin/setuser turtle xmr-stak-cpu /usr/local/etc/config.txt  >>/var/log/xmr-stak.log 2>&1