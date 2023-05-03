# aws-toolkit

This image provides the AWS CLI for use in CI/CD pipeline.

## Scripts

Provided built in scripts run command commands.

Scripts are aliased for easy use.

```bash
# without alias
$ bash /scripts/auth/assumeRole.sh ROLE_ARN
# using alias
$ auth-assume-role ROLE_ARN
```

### Authentication

```bash
# Assume role
# /scripts/auth/assumeRole.sh
auth-assume-role ROLE_ARN
```
