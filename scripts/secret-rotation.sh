#!/bin/bash

set -euo pipefail

SECRET_ID="production/rds/credentials"
REGION="eu-west-2"

aws secretsmanager rotate-secret \
  --secret-id "$SECRET_ID" \
  --region "$REGION"
echo ""
echo "Secret rotated..."
echo ""

kubectl annotate externalsecret memos-dsn -n production \
  force-sync=$(date +%s) --overwrite
echo ""
echo "Overwrote refresh interval to immediate and rotation is done..."
