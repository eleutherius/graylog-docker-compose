#!/bin/bash

test_env=`tail -1 test`
message=`tail -1 /var/log/elasticsearch/fwyl-production.log`
date1=`echo ${message} | cut  -c 1-25`
if [[ "$test_env" != "$date1" ]]; then
hostname='fywl-server'
short_message=`tail -1  /var/log/elasticsearch/fwyl-production.log | cut  -c 33-`
full_message=$message

level=1
facility='some_text'
#date=`tail -1  /var/log/elasticsearch/fwyl-production.log | cut  -c 1-25`
date=$(date +'%s.%N')
env_name='elasticsearch-fywl-server'
app_name='elasticsearch'

# Read the message into the variable ${gelf_message}
# see http://graylog2.org/gelf for mor info

read -r -d '' gelf_message <<EOF
{
  "version": "1.0",
  "host": "${hostname}",
  "short_message": "${short_message}",
  "full_message": "${full_message}",
  "timestamp": ${date},
  "level": ${level},
  "facility": "${facility}",
  "_user_id": 42,
  "_Environment": "${env_name}",
  "_AppName": "${app_name}"
}
EOF

echo ${date1} > test
echo  "${gelf_message}"| gzip -c -f - | nc -w 1 -u 192.168.100.137 12202
#echo "${gelf_message}"
fi
