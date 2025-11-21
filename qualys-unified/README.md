# Qualys Unified Helm Chart

A comprehensive Helm chart for deploying Qualys security sensors in Kubernetes and OpenShift clusters. This unified chart allows you to selectively install:

- **Host-based Container Sensor** - Scans hosts and containers
- **Cluster Sensor** - Discovers and monitors Kubernetes resources
- **Runtime Sensor** - Monitors runtime behavior and detects anomalies
- **QCS Sensor** (Container Security Sensor) - Scans container images for vulnerabilities
- **Admission Controller** - Controls deployments based on security policy

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- Qualys subscription with:
  - Customer ID
  - Activation ID
  - Gateway URL

## Quick Start

### 1. Add the Helm Repository

```bash
helm repo add qualys-helm-chart https://qualys.github.io/Qualys-Helm-Charts/
helm repo update
```

### 2. Create a values file

Create a `my-values.yaml` file with your Qualys credentials:

```yaml
global:
  customerId: "your-customer-id"
  activationId: "your-activation-id"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"
  clusterInfoArgs:
    cloudProvider: "AWS"
    AWS:
      arn: "your-cluster-arn"

# Enable the sensors you need
hostBasedSensor:
  enabled: true
  qualys:
    args:
      providerName: "AWS"

qualysTc:
  enabled: true
  clusterSensor:
    enabled: true
  runtimeSensor:
    enabled: true
  qcsSensor:
    enabled: true
```

### 3. Install the chart

```bash
helm install qualys-sensors qualys-helm-chart/qualys-unified \
  -f my-values.yaml \
  -n qualys --create-namespace
```

## Configuration

### Global Settings

All sensors require the following global configuration:

| Parameter | Description | Required |
|-----------|-------------|----------|
| `global.customerId` | Qualys Customer ID | Yes |
| `global.activationId` | Qualys Activation ID | Yes |
| `global.gatewayUrl` | Qualys Gateway URL | Yes |
| `global.clusterInfoArgs.cloudProvider` | Cloud provider (AWS/AZURE/GCP/OCI/SELF_MANAGED_K8S) | For cluster/runtime sensors |

### Gateway URLs by Platform

| Platform | URL |
|----------|-----|
| US Platform 1 | https://gateway.qg1.apps.qualys.com |
| US Platform 2 | https://gateway.qg2.apps.qualys.com |
| US Platform 3 | https://gateway.qg3.apps.qualys.com |
| EU Platform 1 | https://gateway.qg1.apps.qualys.eu |
| EU Platform 2 | https://gateway.qg2.apps.qualys.eu |

### Host-based Container Sensor

Deploy the Linux Agent for containers to scan host nodes:

```yaml
hostBasedSensor:
  enabled: true
  qualys:
    args:
      providerName: "AWS"  # Required: AWS, GCP, or COREOS
      logLevel: "3"
    image:
      repository: "qualys/qca"
      tag: "latest"
```

**Cloud Provider Values:**
- `AWS` - Amazon Web Services
- `GCP` - Google Cloud Platform
- `COREOS` - CoreOS/Bottlerocket

### Cluster Sensor

Discovers and monitors Kubernetes cluster resources:

```yaml
qualysTc:
  enabled: true
  clusterSensor:
    enabled: true
```

Requires `global.clusterInfoArgs.cloudProvider` to be set.

### Runtime Sensor

Monitors container runtime behavior:

```yaml
qualysTc:
  enabled: true
  runtimeSensor:
    enabled: true
```

### QCS Sensor (Container Security Sensor)

Scans container images for vulnerabilities:

```yaml
qualysTc:
  enabled: true
  qcsSensor:
    enabled: true
    qualys:
      args:
        concurrentScan: "5"  # Range: 1-20
```

### Admission Controller

Controls which images can be deployed:

```yaml
qualysTc:
  enabled: true
  admissionController:
    enabled: true
```

## Cloud Provider Configuration

### AWS

```yaml
global:
  clusterInfoArgs:
    cloudProvider: "AWS"
    AWS:
      arn: "arn:aws:eks:region:account-id:cluster/cluster-name"

hostBasedSensor:
  enabled: true
  qualys:
    args:
      providerName: "AWS"
```

### Azure

```yaml
global:
  clusterInfoArgs:
    cloudProvider: "AZURE"
    AZURE:
      id: "your-cluster-id"
      region: "eastus"

hostBasedSensor:
  enabled: false  # Azure not supported for host-based sensor
```

### Google Cloud Platform (GCP)

```yaml
global:
  clusterInfoArgs:
    cloudProvider: "GCP"
    GCP:
      krn: "krn:qgcp:project-id:region:cluster-name"

hostBasedSensor:
  enabled: true
  qualys:
    args:
      providerName: "GCP"
```

### Self-Managed Kubernetes

```yaml
global:
  clusterInfoArgs:
    cloudProvider: "SELF_MANAGED_K8S"
    SELF_MANAGED_K8S:
      clusterName: "my-cluster"

hostBasedSensor:
  enabled: false  # Not applicable for self-managed
```

## Deployment Scenarios

### Scenario 1: Complete Security Stack (AWS)

Deploy all sensors for comprehensive coverage:

```yaml
global:
  customerId: "ABC12345"
  activationId: "xyz-789"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"
  clusterInfoArgs:
    cloudProvider: "AWS"
    AWS:
      arn: "arn:aws:eks:us-east-1:123456789:cluster/prod-cluster"

hostBasedSensor:
  enabled: true
  qualys:
    args:
      providerName: "AWS"

qualysTc:
  enabled: true
  clusterSensor:
    enabled: true
  runtimeSensor:
    enabled: true
  qcsSensor:
    enabled: true
  admissionController:
    enabled: true
```

### Scenario 2: Host Scanning Only

Deploy only the host-based container sensor:

```yaml
global:
  customerId: "ABC12345"
  activationId: "xyz-789"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"

hostBasedSensor:
  enabled: true
  qualys:
    args:
      providerName: "GCP"

qualysTc:
  enabled: false
```

### Scenario 3: Container Image Scanning (GCP)

Deploy cluster and QCS sensors for image vulnerability scanning:

```yaml
global:
  customerId: "ABC12345"
  activationId: "xyz-789"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"
  clusterInfoArgs:
    cloudProvider: "GCP"
    GCP:
      krn: "krn:qgcp:my-project:us-central1:my-cluster"

hostBasedSensor:
  enabled: false

qualysTc:
  enabled: true
  clusterSensor:
    enabled: true
  qcsSensor:
    enabled: true
    qualys:
      args:
        concurrentScan: "10"
```

### Scenario 4: Runtime Protection (Azure)

Focus on runtime security monitoring:

```yaml
global:
  customerId: "ABC12345"
  activationId: "xyz-789"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"
  clusterInfoArgs:
    cloudProvider: "AZURE"
    AZURE:
      id: "cluster-resource-id"
      region: "eastus"

hostBasedSensor:
  enabled: false

qualysTc:
  enabled: true
  clusterSensor:
    enabled: true
  runtimeSensor:
    enabled: true
```

## OpenShift Configuration

For OpenShift clusters, enable the OpenShift flag:

```yaml
global:
  openshift: true

hostBasedSensor:
  openshift: true
```

## Proxy Configuration

If your cluster requires a proxy to reach Qualys Cloud:

```yaml
global:
  proxy:
    value: "proxy.example.com:8080"
    certificate: "base64-encoded-ca-cert"
    skipVerifyTLS: false
```

## GKE Autopilot

For GKE Autopilot clusters:

```yaml
global:
  gkeAutopilot:
    enabled: true
    allowlistLabelForQcsSensor: "autopilot.gke.io/workload-type=system"
```

## Verification

After installation, verify your sensors are running:

```bash
# Check all Qualys pods
kubectl get pods -n qualys

# Check DaemonSet (host-based sensor)
kubectl get daemonset -n qualys

# Check Deployments (other sensors)
kubectl get deployments -n qualys

# View sensor logs
kubectl logs -n qualys -l app=qualys --tail=100
```

## Upgrading

To upgrade the chart with new values:

```bash
helm upgrade qualys-sensors qualys-helm-chart/qualys-unified \
  -f my-values.yaml \
  -n qualys
```

## Uninstallation

To remove all Qualys sensors:

```bash
helm uninstall qualys-sensors -n qualys
```

## Troubleshooting

### Pods not starting

1. Check if credentials are correct:
   ```bash
   kubectl get pods -n qualys
   kubectl logs -n qualys <pod-name>
   ```

2. Verify cloud provider configuration matches your cluster

3. Ensure namespace exists:
   ```bash
   kubectl create namespace qualys
   ```

### Host-based sensor failing

- Verify `providerName` is one of: AWS, GCP, COREOS
- Check if the sensor has host access (hostNetwork, hostPID, hostIPC)
- Review DaemonSet status:
  ```bash
  kubectl describe daemonset -n qualys qualys-cloud-agent
  ```

### Cluster sensor not reporting

- Verify `global.clusterInfoArgs.cloudProvider` is set correctly
- Check the cluster ARN/ID matches your cloud provider format
- Review sensor logs for authentication errors

## Support

For support and documentation:
- Qualys Documentation: https://docs.qualys.com/
- Helm Chart Repository: https://github.com/Qualys/Qualys-Helm-Charts

## Version Information

- Chart Version: 1.0.0
- qualys-tc: 2.6.1
- lxag_container_agent: 1.0.0
- qcs-sensor: 1.19.0
