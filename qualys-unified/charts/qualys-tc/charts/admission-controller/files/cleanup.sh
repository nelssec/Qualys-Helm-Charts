#!/bin/bash

name="admission-controller"
ns="qualys"
if [ -n "${2}" ];
then
	ns="${2}"
fi

if [ -n "${3}" ];
then
  name="${3}"
fi

echo "Using ns = ${ns}"

kubectl delete validatingwebhookconfiguration/"${name}";
kubectl -n "${ns}" delete secret/"${name}"-certs;