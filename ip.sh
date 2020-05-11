#!/bin/bash

function ping_chk
{
ping=`ping -c 1 $ip | grep bytes | wc -l`
if [ "$ping" -gt 1 ]
then
echo "host active"
echo  $ip >> result.txt
jump ip
else
echo "host inactive"
fi
}
function jump
{
	 service networking restart
         ifconfig eth0 down
	 ifconfig eth0 $ip netmask 255.255.255.0 up
	 route add default gw 192.168.0.253 eth0
	 ifconfig
	sleep 1
}
a=10
b=0
c=0
d=0
ifconfig
while [ $a -lt 100 ]
do 
	ip=$a.$b.$c.$d
	ping_chk ip
	d=$(( $d + 1 ))	
done
