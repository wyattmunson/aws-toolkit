#!/bin/bash
export AWS_DEFAULT_REGION=<+infra.variables.Region>
export AWS_STS_ROLE=<+infra.variables.stsRole>
NAME="Harness-Assume-Role"
export VERSION_LABEL=<+artifact.filePath>

# print header
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/helpers/header.sh | bash -s "HARNESS: ELASTIC BEANSTALK - CREATE VERSION"

# authenticated with AWS
curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/auth/assumeRoleEnvVar.sh | bash -s $AWS_ROLE_ARN

VERSION_EXISTS=`aws elasticbeanstalk describe-application-versions --application-name=<+service.name> --version-labels=${VERSION_LABEL} | jq -r '.ApplicationVersions' | jq length`

if [ $VERSION_EXISTS -gt 0 ]; then
  echo "Version already exists, Harness skipping this step..."
else

echo "Creating EB app version ${VERSION_LABEL} in EB app \"<+service.name>\" on region ${AWS_DEFAULT_REGION}"

aws elasticbeanstalk create-application-version --application-name "<+service.name>" --description "Version created by Harness." \
 --version-label "${VERSION_LABEL}" --source-bundle S3Bucket=<+artifact.bucketName>,S3Key=<+artifact.filePath>
fi
