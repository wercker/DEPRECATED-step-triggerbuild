#!/bin/bash

ENDPOINT="https://app.wercker.com/api/v3/builds/"

JSON="{\"applicationId\":\"$WERCKER_TRIGGERBUILD_APPLICATIONID\"" 

if [ $WERCKER_TRIGGERBUILD_BRANCH ] ; then
  JSON="$JSON, \"branch\":\"$WERCKER_TRIGGERBUILD_BRANCH\""
fi

if [ $WERCKER_TRIGGERBUILD_COMMITHASH ] ; then
  JSON="$JSON, \"commitHash\":\"$WERCKER_TRIGGERBUILD_COMMITHASH\""
fi

if [ $WERCKER_TRIGGERBUILD_MESSAGE ] ; then
  JSON="$JSON, \"message\":\"$WERCKER_TRIGGERBUILD_MESSAGE\""
fi

if [ $WERCKER_TRIGGERBUILD_ENVVARS ] ; then
  JSON="$JSON, \"envVars\":\"$WERCKER_TRIGGERBUILD_ENVVARS\""
fi

JSON="$JSON }"
echo "$JSON"

curl -H "Content-type: application/json" -H "Authorization: Bearer $WERCKER_TRIGGERBUILD_TOKEN" \
  -X POST -d "$JSON" $ENDPOINT

