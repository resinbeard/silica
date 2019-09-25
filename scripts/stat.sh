#! /bin/bash

while true
do
cpu0=`top -1 -b -d1 -n1 | grep Cpu0 | cut -d',' -f4  | head -c 5`;
cpu1=`top -1 -b -d1 -n1 | grep Cpu1 | cut -d',' -f4  | head -c 5`;
cpu2=`top -1 -b -d1 -n1 | grep Cpu2 | cut -d',' -f4  | head -c 5`;
cpu3=`top -1 -b -d1 -n1 | grep Cpu3 | cut -d',' -f4  | head -c 5`; 

echo "cpu0: $cpu0\n";
echo "cpu1: $cpu1\n";
echo "cpu2: $cpu2\n";
echo "cpu3: $cpu3\n";

mem_total=`free -m | awk 'NR==2{printf "%s", $4}'`
mem_used=`free -m | awk 'NR==2{printf "%s", $3}'`

disk_total=`df -h | awk '$NF=="/"{printf "%d", $2}'`;
disk_used=`df -h | awk '$NF=="/"{printf "%d", $3}'`;

ip0=`ip route | grep src | awk -F 'src' '{print $NF; exit}' | awk '{print $1}' | cut -d '.' -f1`;
ip1=`ip route | grep src | awk -F 'src' '{print $NF; exit}' | awk '{print $1}' | cut -d '.' -f2`;
ip2=`ip route | grep src | awk -F 'src' '{print $NF; exit}' | awk '{print $1}' | cut -d '.' -f3`;
ip3=`ip route | grep src | awk -F 'src' '{print $NF; exit}' | awk '{print $1}' | cut -d '.' -f4`;

oscsend localhost 9456 /silica/display/stats/cpu ffff $cpu0 $cpu1 $cpu2 $cpu3;
sleep 0.5;

oscsend localhost 9456 /silica/display/stats/mem ff $mem_total $mem_used;
sleep 0.5;

oscsend localhost 9456 /silica/display/stats/disk ff $disk_total $disk_used;
sleep 0.5;

oscsend localhost 9456 /silica/display/stats/network iiii $ip0 $ip1 $ip2 $ip3;
sleep 0.5;

sleep 2;
done

