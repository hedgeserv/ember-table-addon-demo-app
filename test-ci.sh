#!/bin/sh
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Start Mountebank ...${reset}"
mb --allowCORS &

echo "${green}Setup Mountebank ...${reset}"
node mountebank-server/setup-imposters.js

echo "${green}Run ember test ...${reset}"
ember test
result=1
if [ $? -eq 0 ];then
  echo "${green}Ember test finished successfully.${reset}"
  echo "${green}Start ember server.${reset}"
  ember server -e ci &
  var=$!
  echo "${green}Ember server pid is $var${reset}"
  echo "${green}Run nosetests ...${reset}"
  nosetests
  echo "${green}Shutdown ember server at pid $var.${reset}"
  kill $var
  result=0
else
  echo "${red}Ember test failed.${reset}"
  result=1
fi

echo "${green}Shutdown Mountebank ...${reset}"
mb stop
exist $result
