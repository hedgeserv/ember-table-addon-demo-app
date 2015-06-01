#!/bin/sh
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}[Setup Script]Install Bower ...${reset}"
npm install -g bower

echo "${green}[Setup Script]Install Ember-cli ...${reset}"
npm install -g ember-cli

echo "${green}[Setup Script]Install phantomjs ...${reset}"
npm install -g phantomjs

echo "${green}[Setup Script]Install python ...${reset}"
brew install python

echo "${green}[Setup Script]Install mountebank --production ...${reset}"
npm install -g mountebank --production

echo "${green}[Setup Script]Ready to link ember-table ...${reset}"
cd  ${1}/ember-table
npm link

echo "${green}[Setup Script]Complete link to ember-table ...${reset}"
cd  ${1}/ember-table-addon-demo-app
npm link ember-table

echo "${green}[Setup Script]Install server-side modules locally ...${reset}"
npm install

echo "${green}[Setup Script]Install client-side modules locally ...${reset}"
bower install

echo "${green}[Setup Script]Install pyton requirements ...${reset}"
pip install -r python-webdriver-tests/requirements.txt

echo "${green}[Setup Script]Install successfully ...${reset}"
