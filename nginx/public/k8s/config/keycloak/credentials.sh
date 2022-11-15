#!/bin/bash
while [ $# -gt 0 ]; do
  case "$1" in
    --dbPass=*)
      dbPass="${1#*=}"
      ;;
    --adminPass=*)
      adminPass="${1#*=}"
      ;;
    --namespace=*)
      namespace="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument. $1 \n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

if [[ $dbPass == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --dbPass= \n"
  printf "* --dbPass=Passw0rd! \n"
  printf "*******************************************************************************\n"
  exit 1
fi

if [[ $adminPass == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --adminPass= \n"
  printf "* --adminPass=Passw0rd! \n"
  printf "*******************************************************************************\n"
  exit 1
fi

if [[ $namespace == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --namespace= \n"
  printf "* --namespace=keycloak \n"
  printf "*******************************************************************************\n"
  exit 1
fi


kubectl -n $namespace create secret generic keycloak --from-literal='password='$adminPass
kubectl -n $namespace create secret generic keycloak-psql --from-literal='password='$dbPass
