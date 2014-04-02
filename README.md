## Synopsis

collectd-exec-file_handles is a shell script for collectd to execute to collect system metrics about file handle usage.

## Requirements

Bash

## Metrics published

```
$ bash file_handles.sh
PUTVAL host.foo.com/system-file_handles/gauge-file_handles_used interval=10 N:3200
PUTVAL host.foo.com/system-file_handles/gauge-file_handles_allocatedunused interval=10 N:0
PUTVAL host.foo.com/system-file_handles/gauge-file_handles_max interval=10 N:387375
```
 
## License
 
The MIT License (MIT)
 
Copyright (c) 2014 Phil Dufault
 
