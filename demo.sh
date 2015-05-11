#!/bin/sh

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

trap ctrl_c INT KILL TERM

ctrl_c(){
    echo "${green}Stop Mountebank ...${reset}"
    mb stop
}


echo "${green}Start Mountebank ...${reset}"
mb restart --allowCORS &

echo "${green}Setup Mountebank ...${reset}"
node mountebank-server/setup-imposters.js

echo "${green}Start ember server ...${reset}"
ember server
