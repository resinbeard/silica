#! /bin/bash
declare -a monomes=()
while read line ; do
    if [[ $line == *"failed"* ]]; then
	continue
    fi
    
    monomes+=($(echo $line | cut -d' ' -f 8))
done < /var/log/silica/serialoscd.err


for monome in "${monomes[@]}"
do
    echo $monome
done

