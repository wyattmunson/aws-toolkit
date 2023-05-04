#!/bin/bash

# print header
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/helpers/header.sh | bash -s "FETCH INSTNACES: ELASTIC BEANSTALK"

# authenticated with AWS
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/auth/assumeRoleEnvVar.sh | bash -s 

echo "Checking for Steady State..."
APP_INFO=`aws elasticbeanstalk describe-environments --environment-name <+infra.variables.EnvironmentName>`
APP_STATUS=`echo ${APP_INFO}  | jq '.Environments[] | .Status' | sed -e 's/^"//' -e 's/"$//'`
APP_HEALTHSTATUS=`echo ${APP_INFO}  | jq '.Environments[] | .HealthStatus' | sed -e 's/^"//' -e 's/"$//'`
APP_HEALTH=`echo ${APP_INFO}  | jq '.Environments[] | .Health' | sed -e 's/^"//' -e 's/"$//'`

echo "Current APP Status: " ${APP_STATUS}
echo "Current APP Health Status" ${APP_HEALTHSTATUS}
echo "Current APP Health" ${APP_HEALTH}

while [ "$APP_STATUS" != "Ready" ] || [ "$APP_HEALTHSTATUS" != "Ok" ] || [ "$APP_HEALTH" != "Green" ]; do
  APP_INFO=`aws elasticbeanstalk describe-environments --environment-name <+infra.variables.EnvironmentName>`
  APP_STATUS=`echo ${APP_INFO}  | jq '.Environments[] | .Status' | sed -e 's/^"//' -e 's/"$//'`
  APP_HEALTHSTATUS=`echo ${APP_INFO}  | jq '.Environments[] | .HealthStatus' | sed -e 's/^"//' -e 's/"$//'`
  APP_HEALTH=`echo ${APP_INFO}  | jq '.Environments[] | .Health' | sed -e 's/^"//' -e 's/"$//'`
  echo "---"
  echo "Checking for Steady State..."
  echo "Current APP Status: " ${APP_STATUS} " - Desired: Ready "
  echo "Current APP Health Status" ${APP_HEALTHSTATUS} " - Desired: Ok"
  echo "Current APP Health" ${APP_HEALTH} " - Desired: Green"
  sleep 2
done

echo "------"
echo ${APP_INFO}