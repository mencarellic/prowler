#!/bin/bash
set -euo pipefail

DATE=$(date +"%Y-%m-%d")
BUCKETPATH="s3://${BUCKET}/${DATE}/${GROUPID}.txt"
WHITELIST_FILE="whitelist"

OUTPUT=$(./prowler -g $GROUPID -r $REGION -f $REGION -w $WHITELIST_FILE -n -M mono || true )

echo "$OUTPUT" > /tmp/${GROUPID}.txt

aws s3 cp /tmp/${GROUPID}.txt ${BUCKETPATH}