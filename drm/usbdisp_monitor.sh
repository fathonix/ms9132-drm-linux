#!/bin/bash

pre_xorg_pid=0
disp_num=0

while [ 1 ];
do
    cur_xorg_pid=$(ps -ef | grep Xorg | grep -v grep | awk '{print $2}')
    if [ -z "$cur_xorg_pid" ]; then
        sleep 5
        continue
    fi

    if [ $pre_xorg_pid != $cur_xorg_pid ]; then
        tmp=$(ps -ef | grep Xorg | grep -v grep)
        cookie_path=$(getopt -lauth: -a opt1 $tmp 2>/dev/null | awk '{print $2'} | tr -d \')
        disp_num=${cookie_path:$(expr index $cookie_path ":")}
        if [ $UID == "0" ]; then
            cp $cookie_path $HOME/.Xauthority
        fi
        pre_xorg_pid=$cur_xorg_pid
        logger "pre_xorg_pid: $pre_xorg_pid"
    fi 

    src_xid=$(xrandr -d :$disp_num --listproviders | grep "Source Output" | awk '{print $4}' | cut -d " " -f1)
    #echo "src_xid:$src_xid"
    provider_xids=$(xrandr -d :$disp_num --listproviders | grep -v Providers | grep -v "Source Output" | awk '{print $4}')
    associated=$(xrandr -d :$disp_num --listproviders | grep -v Providers | grep -v "Source Output" | awk '{print $15}')
    #echo $associated
    if [ -z "$src_xid" ] || [ -z "$provider_xids" ] || [ -z "$associated" ]; then
        sleep 5
        continue
    fi

    index=1;
    for xid in $provider_xids; do
        has_set=$(echo $associated | cut -d " " -f$index)
        if [ "$has_set" == "0" ]; then
            logger "set provider $index"
            xrandr -d :$disp_num --setprovideroutputsource $xid $src_xid
        fi
        let index++
    done

    conn_outputs=$(xrandr -d :$disp_num | grep -v disconnected | grep connected | grep -v -E '^.* [0-9]+x[0-9]+' | awk '{print $1}')
    for conn_output in $conn_outputs; do
        logger "set output $conn_output auto"
        xrandr -d :$disp_num --output $conn_output --auto
    done
    sleep 5
done

