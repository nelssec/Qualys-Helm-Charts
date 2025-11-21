## admission-controller installation example:

---
#### Default or helm based self-signed certificate creation:

---
    helm upgrade --install --namespace qualys --create-namespace \
    --set admission-controller.enabled=true \
    --set clusterSensor.enabled=false \
    --set global.clusterInfoArgs.name=`kubectl config current-context` \
    --set global.customerId="7a00a660-36bb-f02b-8025-9fcf49faf0b7" \
    --set global.activationId="6e94db51-6957-4f40-90c5-47e724c6c46e" \
    --set global.gatewayUrl="https://gateway.p24.eng.sjc01.qualys.com" \
    --set admission-controller.image="art-hq.intranet.qualys.com:5001/qualys/cs/cs-k8s-admission-controller:1.33.0-16" \
    admission-controller qualys-tc

---

#### Cert-Manager based self-signed certificate creation:

---
    helm upgrade --install --namespace qualys --create-namespace \
    --set admission-controller.enabled=true \
    --set clusterSensor.enabled=false \
    --set global.clusterInfoArgs.name=`kubectl config current-context` \
    --set global.customerId="7a00a660-36bb-f02b-8025-9fcf49faf0b7" \
    --set global.activationId="6e94db51-6957-4f40-90c5-47e724c6c46e" \
    --set global.gatewayUrl="https://gateway.p24.eng.sjc01.qualys.com" \
    --set admission-controller.image="art-hq.intranet.qualys.com:5001/qualys/cs/cs-k8s-admission-controller" \
    --set admission-controller.tag="1.33.0-16" \
    --set admission-controller.certs.certsProvider="cert-manager" \
    admission-controller qualys-tc
---
#### User supplied certs (no self-signed certificates created):

---
    helm upgrade --install --namespace qualys --create-namespace \
    --set admission-controller.enabled=true \
    --set clusterSensor.enabled=false \
    --set global.clusterInfoArgs.name=`kubectl config current-context` \
    --set global.customerId="7a00a660-36bb-f02b-8025-9fcf49faf0b7" \
    --set global.activationId="6e94db51-6957-4f40-90c5-47e724c6c46e" \
    --set global.gatewayUrl="https://gateway.p24.eng.sjc01.qualys.com" \
    --set admission-controller.image="art-hq.intranet.qualys.com:5001/qualys/cs/cs-k8s-admission-controller" \
    --set admission-controller.tag="1.33.0-16" \
    --set admission-controller.certs.certsProvider=none \
    --set admission-controller.webhook.caBundle=`cat /path/to/ca.crt | base64 | tr -d '\n'` \
    --set admission-controller.certs.serverCertificate=`cat /path/to/server.crt | base64 | tr -d '\n'` \
    --set admission-controller.certs.serverKey=`cat /path/to/server.key | base64 | tr -d '\n'` \
    admission-controller qualys-tc

---


## Uninstallation:

---

    helm uninstall -n qualys admission-controller
    ./admission-controller/files/cleanup.sh