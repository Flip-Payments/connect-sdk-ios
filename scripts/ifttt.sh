#!/bin/bash
set -e
set -x

MESSAGE="💔 <b>$BITRISE_APP_TITLE</b> build $BITRISE_BUILD_NUMBER failed<br/>URL: $BITRISE_APP_URL<br/>Commit: $BITRISE_GIT_COMMIT - $BITRISE_GIT_MESSAGE <br/>Git URL: $GIT_REPOSITORY_URL <br/>"

if [ $BITRISE_BUILD_STATUS -eq 0 ] ; then MESSAGE="✅ <b>$BITRISE_APP_TITLE</b> build $BITRISE_BUILD_NUMBER passed! ❤️<br/>URL: $BITRISE_APP_URL<br/>" ; fi 

curl -X POST -H "Content-Type: application/json" -d "{\"value1\":\"$MESSAGE\"}" https://maker.ifttt.com/trigger/build_failed/with/key/$IFTTT_TOKEN
