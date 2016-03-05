#!/bin/bash
set -e

if [[ -x $1 ]]; then
  $1
else
  if [[ ! -z "$JENKINS_URL" ]]; then
      URL="-jnlpUrl $JENKINS_URL"
  fi
  if [[ ! -z "$JENKINS_SECRET" ]]; then
      SECRET="-secret $JENKINS_SECRET"
  fi

  java -jar /usr/share/jenkins/slave.jar $URL $SECRET "$@"
fi

exit 0