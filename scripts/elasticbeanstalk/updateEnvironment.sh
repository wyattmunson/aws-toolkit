#!/bin/bash

# print header
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/helpers/header.sh | bash -s "FETCH INSTNACES: ELASTIC BEANSTALK"

# authenticated with AWS
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/auth/assumeRoleEnvVar.sh | bash 

# See if EB_APP_VERSION is in the EB app
NB_VERS=`aws elasticbeanstalk describe-applications --application-name "<+service.name>" | jq '.Applications[] | .Versions[]' | grep -c "\"${VERSION_LABEL}\""`
if [ ${NB_VERS} = 0 ];then
	echo "No app version called \"${VERSION_LABEL}\" in EB application \"${EB_APP}\"."
	exit 4
fi

aws elasticbeanstalk update-environment --environment-name <+infra.variables.EnvironmentName> --version-label ${VERSION_LABEL}