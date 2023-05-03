#!/bin/bash
bash ./scripts/helpers/header.sh "AWS Auth: Configration"

FILE_NAME="~/.aws/config"
CRED_FILE="~/.aws/config"

echo "[default]" >> $FILE_NAME
echo "region = us-east-1" >> $FILE_NAME
echo "ouput = json" >> $FILE_NAME
echo "[default]" >> $CRED_FILE
echo "aws_access_key_id = $AWS_ACCESS_KEY" >> $CRED_FILE
echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> $CRED_FILE

aws sts get-caller-identity
