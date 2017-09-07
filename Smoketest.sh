#!/bin/bash
status=`curl -s -o /dev/null -w "%{http_code}" http://localhost:8182/`
if [ $status == 200 ] 
then 
echo "TEST is OK " 
else exit 1 
fi
