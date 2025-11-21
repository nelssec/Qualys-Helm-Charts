# Qualys Unified Helm Chart

A comprehensive Helm chart for deploying Qualys security sensors in Kubernetes and OpenShift clusters. This unified chart allows you to selectively install:

- **Host Sensor** - Scans hosts and containers
- **Cluster Sensor** - Discovers and monitors Kubernetes resources
- **Runtime Sensor** - Monitors runtime behavior and detects anomalies
- **General Sensor** - Scans container images for vulnerabilities
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
hostsensor:
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

**Option A: Install with values file**

```bash
helm install qualys-sensors qualys-helm-chart/qualys-unified \
  -f my-values.yaml \
  -n qualys --create-namespace
```

**Option B: Install with command-line flags**

```bash
# Example: Cluster + General Sensors only
helm install qualys-sensors qualys-helm-chart/qualys-unified \
  --set global.customerId=dd6ac00f-cac2-5630-82f9-44cb9fcee66c \
  --set global.activationId=be2bcfe0-21dd-4108-ab9f-26976c435ed7 \
  --set global.gatewayUrl=https://gateway.qg2.apps.qualys.com \
  --set global.cmsqagPublicUrl=https://cmsqagpublic.qg2.apps.qualys.com/ContainerSensor \
  --set global.clusterInfoArgs.cloudProvider=AWS \
  --set global.clusterInfoArgs.AWS.arn="arn:aws:eks:region:account:cluster/name" \
  --set hostsensor.enabled=false \
  --set qualysTc.enabled=true \
  --set qualysTc.clusterSensor.enabled=true \
  --set qualysTc.qcsSensor.enabled=true \
  --set qualysTc.qcsSensor.qualys.args.performScaScan=true \
  --set qualysTc.qcsSensor.qualys.args.enableConsoleLogs=true \
  --set qualysTc.qcsSensor.qualys.args.withoutPersistentStorage=true \
  --namespace qualys --create-namespace

# Example: Host Sensor only
helm install qualys-sensors qualys-helm-chart/qualys-unified \
  --set hostsensor.enabled=true \
  --set hostsensor.qualys.args.providerName=AWS \
  --set hostsensor.qualys.args.activationId=YOUR_HOST_ACTIVATION_ID \
  --set hostsensor.qualys.args.customerId=YOUR_HOST_CUSTOMER_ID \
  --set hostsensor.qualys.args.serverUri=https://gateway.qg2.apps.qualys.com \
  --set qualysTc.enabled=false \
  --namespace qualys --create-namespace

# Example: All Sensors (with SEPARATE credentials for host sensor)
helm install qualys-sensors qualys-helm-chart/qualys-unified \
  --set global.customerId=CLUSTER_CUSTOMER_ID \
  --set global.activationId=CLUSTER_ACTIVATION_ID \
  --set global.gatewayUrl=https://gateway.qg2.apps.qualys.com \
  --set global.cmsqagPublicUrl=https://cmsqagpublic.qg2.apps.qualys.com/ContainerSensor \
  --set global.clusterInfoArgs.cloudProvider=AWS \
  --set global.clusterInfoArgs.AWS.arn="arn:aws:eks:region:account:cluster/name" \
  --set hostsensor.enabled=true \
  --set hostsensor.qualys.args.providerName=AWS \
  --set hostsensor.qualys.args.activationId=HOST_ACTIVATION_ID \
  --set hostsensor.qualys.args.customerId=HOST_CUSTOMER_ID \
  --set hostsensor.qualys.args.serverUri=https://gateway.qg2.apps.qualys.com \
  --set qualysTc.enabled=true \
  --set qualysTc.clusterSensor.enabled=true \
  --set qualysTc.qcsSensor.enabled=true \
  --set qualysTc.qcsSensor.qualys.args.performScaScan=true \
  --namespace qualys --create-namespace
```

## Configuration

### Important: Separate Credentials for Host Sensor

**The host sensor typically uses DIFFERENT credentials than cluster/runtime/general sensors.**

- **Global credentials** (`global.customerId`, `global.activationId`): Used by cluster sensor, runtime sensor, general sensor, and admission controller
- **Host sensor credentials** (`hostsensor.qualys.args.customerId`, `hostsensor.qualys.args.activationId`): Used only by the host sensor

You can obtain these separate activation IDs from different sections in the Qualys platform:
- **Host sensor**: From the Container Security > Sensors > Host Sensor section
- **Cluster sensors**: From the Container Security > Sensors > Kubernetes section

### Global Settings

Global settings apply to cluster sensor, runtime sensor, general sensor, and admission controller:

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

### Host Sensor

Deploy the Linux Agent for containers to scan host nodes. **Note: This sensor uses separate credentials.**

```yaml
hostsensor:
  enabled: true
  qualys:
    args:
      providerName: "AWS"  # Required: AWS, GCP, or COREOS
      # Host sensor-specific credentials (different from global)
      activationId: "YOUR_HOST_SENSOR_ACTIVATION_ID"
      customerId: "YOUR_HOST_SENSOR_CUSTOMER_ID"
      serverUri: "https://gateway.qg2.apps.qualys.com"
      logLevel: "3"
    image:
      repository: "qualys/qca"
      tag: "latest"
```

**Cloud Provider Values:**
- `AWS` - Amazon Web Services
- `GCP` - Google Cloud Platform
- `COREOS` - CoreOS/Bottlerocket

**Credential Inheritance:**
- If `hostsensor.qualys.args.activationId` is not specified, it inherits from `global.activationId`
- If `hostsensor.qualys.args.customerId` is not specified, it inherits from `global.customerId`
- Best practice: Always specify separate credentials for the host sensor

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

### General Sensor

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

hostsensor:
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

hostsensor:
  enabled: false  # Azure not supported for host sensor
```

### Google Cloud Platform (GCP)

```yaml
global:
  clusterInfoArgs:
    cloudProvider: "GCP"
    GCP:
      krn: "krn:qgcp:project-id:region:cluster-name"

hostsensor:
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

hostsensor:
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

hostsensor:
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

Deploy only the host sensor:

```yaml
global:
  customerId: "ABC12345"
  activationId: "xyz-789"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"

hostsensor:
  enabled: true
  qualys:
    args:
      providerName: "GCP"

qualysTc:
  enabled: false
```

### Scenario 3: Container Image Scanning (GCP)

Deploy cluster and general sensors for image vulnerability scanning:

```yaml
global:
  customerId: "ABC12345"
  activationId: "xyz-789"
  gatewayUrl: "https://gateway.qg1.apps.qualys.com"
  clusterInfoArgs:
    cloudProvider: "GCP"
    GCP:
      krn: "krn:qgcp:my-project:us-central1:my-cluster"

hostsensor:
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

hostsensor:
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

hostsensor:
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

### Host sensor failing

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
