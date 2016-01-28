#!/bin/bash
# Author: Phil Dufault (phil@dufault.info)
# Date: April 2nd, 2014
# Use: collectd exec script to collect system file handle metrics

HOSTNAME="${COLLECTD_HOSTNAME:-`hostname -f`}"
INTERVAL="${COLLECTD_INTERVAL:-10}"

while sleep "$INTERVAL"; do

  # Historically, the three values in file-nr denoted the number of
  # * allocated file handles
  # * the number of allocated but unused file handles
  # * the maximum number of file handles.
  # Linux 2.6 always reports 0 as the number of free file handles -- this is not an error, it just means that the number of allocated file handles exactly matches the number of used file handles.

  # Grab the metrics
  file_nr=($(cat /proc/sys/fs/file-nr))
  allocated=${file_nr[0]}
  allunused=${file_nr[1]}
  max=${file_nr[2]}

  # Output time
  echo "PUTVAL $HOSTNAME/system-file_handles/gauge-file_handles_used interval=$INTERVAL N:$allocated"
  echo "PUTVAL $HOSTNAME/system-file_handles/gauge-file_handles_allocatedunused interval=$INTERVAL N:$allunused"
  echo "PUTVAL $HOSTNAME/system-file_handles/gauge-file_handles_max interval=$INTERVAL N:$max"

  # putval format
  #            <instance-id>/<plugin>-<plugin_instance>/<type>-<type_instance>

done
