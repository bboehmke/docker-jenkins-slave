#!/bin/bash
set -e

if [[ -x $1 ]]; then
  "$@"
else
  if [[ ! -z "$JENKINS_URL" ]]; then
      URL="-url $JENKINS_URL"
  fi

  java -cp /opt/slave.jar hudson.remoting.jnlp.Main -headless $URL $JENKINS_SECRET $JENKINS_NODE_NAME "$@"

fi

exit 0