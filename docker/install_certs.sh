#!/bin/bash

ls docker/certs/*.crt &> /dev/null
if [ $? -ne 0 ];
then
    echo "No additional certificates found. Skipping."
    exit 0;
fi

for C in docker/certs/*.crt;
do
    cp -f "${C}" /usr/share/ca-certificates/mozilla/
    CB=`basename "${C}"`
    echo "mozille/${CB}" >> /etc/ca-certificates.conf
done
/usr/sbin/update-ca-certificates
