#!/bin/bash
bash ./scripts/helpers/header.sh "AWS Auth: Role Aussumption"

if [[ -z $1 ]]; then
    echo "ERR: No role to assume."
    echo "ERR: Call this scipt with the role to assume as the first argument. Exiting"
    exit 1
fi

echo "EXISTING ROLE BEFORE ASSUMPTION:"
aws sts get-caller-identity

if [[ $? -gt 0 ]]; then
    echo "ERR: No existing role found. Exiting."
    echo "ERR: An existing role must exist on the machine to assume another role."
    exit 1
fi

aws sts assume-role --role-arn $1 --role-session-name prod-blue-eks-creation >> credentials.json
export AWS_SECRET_ACCESS_KEY=$(cat credentials.json | grep "SecretAccessKey" | cut -d ':' -f2 | cut -d '"' -f2)
export AWS_SESSION_TOKEN=$(cat credentials.json | grep "SessionToken" | cut -d ':' -f2 | cut -d '"' -f2)
export AWS_ACCESS_KEY_ID=$(cat credentials.json | grep "AccessKeyId" | cut -d ':' -f2 | cut -d '"' -f2)

echo ""
echo "NEW ROLE AFTER ASSUMPTION:"
aws sts get-caller-identity

echo "Role assumption complete."