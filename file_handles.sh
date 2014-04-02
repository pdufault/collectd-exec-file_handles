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

  # Collect data into a temp variable
  array=$(< /proc/sys/fs/file-nr)

  # Grab the metrics
  allocated=$(awk '{print $1}' <<< $array)
  allunused=$(awk '{print $2}' <<< $array)
  max=$(awk '{print $3}' <<< $array)

  # Output time
  echo "PUTVAL $HOSTNAME/system-file_handles/gauge-file_handles_used interval=$INTERVAL N:$allocated"
  echo "PUTVAL $HOSTNAME/system-file_handles/gauge-file_handles_allocatedunused interval=$INTERVAL N:$allunused"
  echo "PUTVAL $HOSTNAME/system-file_handles/gauge-file_handles_max interval=$INTERVAL N:$max"

  # putval format
  #            <instance-id>/<plugin>-<plugin_instance>/<type>-<type_instance>

done
