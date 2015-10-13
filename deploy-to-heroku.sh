#!/bin/sh

remote='heroku'

current_br=`git rev-parse --abbrev-ref HEAD`

while getopts n:r: opt; do
    case $opt in
        n)
          app_name=${OPTARG}
        ;;
        r)
          remote=${OPTARG}
        ;;
        \?)
          echo "Invalid param"
        ;;
    esac
done

if [ NOT $app_name ]; then
  echo "
    Run with

      -n heroku app name.
      -r remote name. The default value is 'heroku'.

    Such as

      ./deploy-to-heroku.sh -n <app name> -r <remote name>
  " && exit 1
fi

fname=$app_name # front end name
bname=${app_name}-back # back end name

fremote=$remote # heroku git remote name for front end
bremote=${remote}-back # heroku git remote name for back end

echo Front name is $fname
echo Back name is $bname

create_app () {
  name=$1
  remote=$2
  echo Create App $name
  heroku create $name --buildpack $3

  if [ $? -eq 1 ]; then
    echo 'Create Heroku error. Please clear your heroku apps and retry.' && exit 1
  fi

  heroku config:set REBUILD_ALL=true --app $name

  remote_url=https://git.heroku.com/${name}.git

  git remote rm $remote

  git remote add $remote $remote_url
}

# Deploy front end

create_app $fname $fremote https://github.com/tonycoco/heroku-buildpack-ember-cli.git

heroku config:set API_URL=http://${bname}.herokuapp.com --app $fname

heroku config:set API_PREFIX_PATH='/api/' --app $fname

git push $fremote $current_br:master

# Deploy back end

create_app $bname $bremote https://github.com/heroku/heroku-buildpack-nodejs.git

heroku buildpacks:add --index 2 https://github.com/li-qiang/ember-table-demo-app-stub-server-buildpack.git --app $bname

git push $bremote $current_br:master

heroku open --app $fname
