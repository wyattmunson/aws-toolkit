#!/bin/bash

# print header
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/helpers/header.sh | bash -s "FETCH INSTNACES: ELASTIC BEANSTALK"

# authenticated with AWS
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/auth/assumeRoleEnvVar.sh | source


# describe instance health
aws elasticbeanstalk describe-instances-health --environment-name=<+infra.variables.ebEnvironmentName> > $INSTANCE_OUTPUT_PATH
cat $INSTANCE_OUTPUT_PATH