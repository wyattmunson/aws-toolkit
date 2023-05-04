#!/bin/bash

curl -s https://raw.githubusercontent.com/wyattmunson/aws-toolkit/main/scripts/helpers/header.sh | bash -s "ASSUMING AWS ROLE"


export AWS_DEFAULT_REGION=<+infra.variables.awsRegion>
export AWS_ROLE_ARN=<+infra.variables.awsRoleArn>
NAME="Harness-Assume-Role"

if [ "$AWS_ROLE_ARN" != "None" ]; then
    echo "INFO: AWS_ROLE_ARN env var detected. Attempting to assume it."
    echo "INFO: To prevent role assumption, set AWS_ROLE_ARN env var to 'None'."
    echo "INFO: AWS_ROLE_ARN resolves to: $AWS_ROLE_ARN"
    echo "Assuming STS Role..."

    # Cleanup current sessions
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN
    unset AWS_ACCESS_KEY AWS_SECRET_KEY AWS_DELEGATION_TOKEN

    KST=(`aws sts assume-role --role-arn "$AWS_ROLE_ARN" \
            --role-session-name "$NAME" \
            --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' \
            --output text`)

    export AWS_ACCESS_KEY_ID=${KST[0]}
    export AWS_SECRET_ACCESS_KEY=${KST[1]}
    export AWS_SESSION_TOKEN=${KST[2]}

else
   echo "Variable AWS_ROLE_ARN set to 'None'"
   echo "Skipping STS AssumeRole..."
fi
