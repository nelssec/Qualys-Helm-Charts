# Qualys Helm Charts

This repository provides a unified Helm chart for deploying Qualys security sensors on Kubernetes and OpenShift clusters.

## Quick Start

Add the Helm repository:

```bash
helm repo add qualys https://nelssec.github.io/Qualys-Helm-Charts/
helm repo update
```

Install the unified chart:

```bash
helm install qualys-sensors qualys/qualys-unified \
  --set global.customerId=YOUR_CUSTOMER_ID \
  --set global.activationId=YOUR_ACTIVATION_ID \
  --set global.qualysPod=US2 \
  --set global.clusterInfoArgs.cloudProvider=AWS \
  --set global.clusterInfoArgs.AWS.arn=YOUR_CLUSTER_ARN \
  --set qualysTc.clusterSensor.enabled=true \
  --set qualysTc.qcsSensor.enabled=true \
  --namespace qualys \
  --create-namespace
```

## Available Chart

### qualys-unified

A unified Helm chart that deploys all Qualys sensors:
- **Host Sensor** - Scans container hosts (AWS, GCP, OpenShift)
- **Cluster Sensor** - Kubernetes cluster security
- **General Sensor** - Container image vulnerability scanning
- **Runtime Sensor** - Runtime threat detection
- **Admission Controller** - Kubernetes admission control

For complete documentation, see the [chart README](https://github.com/nelssec/Qualys-Helm-Charts/tree/main/qualys-unified).

## Documentation

- [Chart Values Configuration](https://github.com/nelssec/Qualys-Helm-Charts/blob/main/qualys-unified/README.md)
- [Qualys Platform Identification](https://www.qualys.com/platform-identification/)
- [GitHub Repository](https://github.com/nelssec/Qualys-Helm-Charts)
