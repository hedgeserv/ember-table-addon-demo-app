#!/bin/sh

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

param="$1"   # start, stop
env="$2"     # dev, "", test.

server_pid_file='server.pid'

start() {

    echo "${green}Start Mountebank ...${reset}"
    mb restart --allowCORS &
    echo "${green}Setup Mountebank ...${reset}"
    node mountebank-server/setup-imposters.js


    # ember test
    if [[ $env = "test" ]]; then
        echo "${green}Start ember test ...${reset}"
        ember test
    # ember server
    else
        if [[ -f server_pid_file ]]; then
            server_pid=`cat $server_pid_file`
        fi

        if [[ -n $server_pid ]]; then
            echo "${green}Mountebank is already started ...${reset}"
        else
            echo "${green}Start ember server ...${reset}"
            ember server -e ci &
            server_pid=$!
            echo "${green}Ember server pid is $server_pid${reset}"
            touch server.pid
            echo $server_pid > server.pid
        fi        
    fi
}

stop(){

    # stop mountebank
    mb stop

    # stop ember server
    if [[ -n server_pid_file ]]; then
        echo "${green}Stop ember server ...${reset}"
        cat server.pid | xargs kill
        rm server.pid
    else
        echo "${green}Ember server ISNOT started ...${reset}"
    fi
}


if [[ $param = "start" ]]; then
    start

elif [[ $param = "stop" ]]; then
    stop

else
    echo 'Unknow argument'
fi





