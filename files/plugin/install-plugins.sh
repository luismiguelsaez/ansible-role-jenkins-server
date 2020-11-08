#!/bin/bash

JENKINS_HOME=$1
shift
PLUGINS_LIST=$@

doInstall(){

 NAME=$(echo $1 | cut -f1 -d:)
 VERS=$(echo $1 | cut -f2 -d:)

 if [ ! -d ${JENKINS_HOME}/plugins/${NAME} ]
 then 
  curl -sL https://updates.jenkins-ci.org/latest/${NAME}.hpi -o ${JENKINS_HOME}/plugins/${NAME}.hpi

  unzip -qu -d ${JENKINS_HOME}/plugins/${NAME} ${JENKINS_HOME}/plugins/${NAME}.hpi

  if `grep "Plugin-Dependencies:" ${JENKINS_HOME}/plugins/${NAME}/META-INF/MANIFEST.MF >/dev/null 2>&1`
  then
    for PD in $(cat ${JENKINS_HOME}/plugins/${NAME}/META-INF/MANIFEST.MF | tr -d '\r' | sed -e ':a;N;$!ba;s/\n //g' | grep "Plugin-Dependencies:" | sed -e 's/Plugin-Dependencies://g' -e 's/,/ /g' )
    do
      doInstall $PD
    done
  fi
  return 1
 else
  return 0
 fi
}

RES=0
 
for PLUGIN in ${PLUGINS_LIST}
do
  doInstall $PLUGIN
  RES=$(($RES + $?))
done

if [ $RES -gt 0 ]
then
  echo "CHANGED"
else
  echo "OK"
fi
