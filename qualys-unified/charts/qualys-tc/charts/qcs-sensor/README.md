# Qualys Container Security Sensor

[Qualys Container Security](https://www.qualys.com/) continuously secure containers from build to runtime.

The installation will deploy the Qualys Container Security Sensor on each worker node as a daemon set. By default, it assumes `containerd` and `CRI-O` as the default runtimes on `Kubernetes cluster` and `OpenShift Cluster`, respectively. If you are using a different container runtime, provide the appropriate value in the helm chart configuration.

## Prerequisites

### Know Your Runtime

Get the details about the container runtime by executing the following command:

`kubectl get nodes -o wide`

### Kubernetes & Helm

- Kubernetes 1.17+
- Helm v3.10.x

### Get Repository Info

- helm repo add qualys-helm-chart https://qualys.github.io/Qualys-Helm-Charts/
- helm repo update

#### RedHat OpenShift

- OpenShift v4.0+ (Default Container Engine is CRI-O)

## Installing the Chart

Use the following command to install the chart:

`helm install [NAME] [CHART] [flags]`

- Install on Kubernetes cluster with containerd runtime (Default)
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor --namespace qualys --create-namespace --set qualys.customerID=${CUSTOMERID},qualys.activationID=${ACTIVATIONID},qualys.pod_url=${POD_URL}`
---
- Install on Kubernetes cluster with cri-o runtime
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor --namespace qualys --create-namespace --set qualys.customerID=${CUSTOMERID},qualys.activationID=${ACTIVATIONID},qualys.pod_url=${POD_URL},crio.enabled=true`
---
- Install on Kubernetes cluster with docker runtime
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor --namespace qualys --create-namespace --set qualys.customerID=${CUSTOMERID},qualys.activationID=${ACTIVATIONID},qualys.pod_url=${POD_URL},docker.enabled=true`
---
- Install on OpenShift cluster with cri-o runtime (Default)
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor --namespace qualys --create-namespace --set qualys.customerID=${CUSTOMERID},qualys.activationID=${ACTIVATIONID},qualys.pod_url=${POD_URL},openshift=true,crio.enabled=true`
---

## Upgrading the Release

Use the following command to upgrade the chart:

`helm upgrade [RELEASE] [CHART] [flags]`

Where,

[RELEASE] is the release name.

[CHART] is the chart path.

e.g.

`helm upgrade qcs-sensor-demo qualys-helm-chart/qcs-sensor --namespace qualys`

## Uninstalling the Chart

Use the following command to uninstall the chart:

`helm uninstall RELEASE_NAME [...] [flags]`

e.g.

`helm uninstall qcs-sensor-demo --namespace qualys`

## Configuration

#### Configurable Parameters

The following table lists the configurable parameters for the Qualys Container Security chart and their default values:

Parameter | Description | Default | Notes
--------- | ----------- | ------- | -----
`containerd.enabled` | Set to true, if the container runtime is containerd. | `true` | **Important**: Enable only one runtime environment. |
`containerd.socketPath` | The host path of the mounted volume for the containerd socket. | `/var/run/containerd/containerd.sock` | Optional |
`containerd.storageDriverPath` | The root directory path of containerd overlay storage driver | `/var/lib/containerd` | Optional |
`crio.enabled` | Set to true, if the container runtime is CRI-O. | `false` | **Important**: Enable only one runtime environment. |
`crio.socketPath` | The host path of the mounted volume for the CRI-O socket. | `/var/run/crio/crio.sock` | Optional |
`crio.storageDriverType` | Specify the crio overlay storage driver type | `overlay` | Optional |
`docker.enabled` | Set to true, if the container runtime is docker. | `false` | **Important**: Enable only one runtime environment. |
`docker.socketPath` | The host path of the mounted volume for the docker socket. | `/var/run/docker.sock` | Optional |
`docker.tlsVerify.enabled` | Enables the TLS authentication. The value should be 0 or 1. | `false` | Optional |
`docker.tlsVerify.tlsCertPath` | Provide the path of the client certificate directory. | `-` | Optional (Mandatory if DOCKER_TLS_VERIFY=1 is defined). |
`docker.tlsVerify.dockerHost` | Specify the address on which the docker daemon is configured to listen. | `-` | Optional (Mandatory if DOCKER_TLS_VERIFY=1 is defined). |
`docker.tlsVerify.dockerHostValue` | Specify the loopback IPv4 address or hostname, and port <IPv4 address or hostname>:<port#>. | `-` | Optional |
`docker.storageDriverPath` | The root directory path of docker overlay2 storage driver | `/var/lib/docker` | Optional |
`docker.storageDriverType` | Specify the docker overlay2 storage driver type | `overlay2` | Optional |
`openshift` | Set to true, if deploying in OpenShift. | `false` |
`qualys.createNamespace` | Set to true, if you want to create new custom namespace. | `false` | Optional |
`qualys.namespace` | Provide the namespace to be used. | `qualys` | Optional `Use the same namespace in values.yaml and on command line when using the helm install command. Check the examples at the bottom of this page.` |
`qualys.customerID` | Provide the Qualys customer id. | `-` | Mandatory |
`qualys.activationID` | Provide the Qualys activation id. | `-` | Mandatory |
`qualys.pod_url` | Provide the URL of a Qualys POD. | `-` | Mandatory |
`qualys.containerLaunchTimeout` | Specify the launch timeout for the scanning container in minutes. | `10` | Optional |
`qualys.image` | Specify the name of the Container Security sensor image in the private/dockerhub registry. | `qualys/qcs-sensor:1.40.1-0` | Optional |
`qualys.imagePullPolicy` | Specify how to pull (download) the specified image. | `Always` | Optional |
`qualys.cpu` | Specify the CPU limit for the sensor container. | `500m` | Optional |
`qualys.args.withoutPersistentStorage` | Runs the sensor without using the persistent storage on the host. | `false` | Optional |
`qualys.args.enableConsoleLogs` | Prints logs on the console. | `false` | Optional |
`qualys.args.cicdDeployedSensor` | Run the sensor in a CI/CD environment. | `false` | Optional |
`qualys.args.registrySensor` | Run the sensor to list and scan the registry assets. | `false` | Optional |
`qualys.args.concurrentScan` | Specify the number of docker/registry asset scans to run in parallel. Valid range: 1-20. | `4` | Optional |
`qualys.args.disableLog4jScanning` | Disables the log4j vulnerability scanning for container images. | `false` | Optional |
`qualys.args.disableLog4jStaticDetection` | Disables the log4j static detection for dynamic/static image scans. | `false` | Optional |
`qualys.args.logFilePurgeCount` | The maximum number of sensor log files to archive. | `5` | Optional |
`qualys.args.logFileSize` | The maximum size for a sensor log file in bytes. You can specify "<digit><K/M/>", where K is kilobytes and M is megabytes. | `10M` | Optional |
`qualys.args.logLevel` | Sets the logging level for sensor. It determines the type of sensor data you want to log. Specify a value from 0 to 5. 0=FATAL, 1=ERROR, 2=WARNING, 3=INFORMATION, 4=VERBOSE, 5=TRACE | `3 (INFORMATION)` | Optional |
`qualys.args.maskEnvVariable` | Masks the environment variables for images and containers. | `false` | Optional |
`qualys.args.optimizeImageScans` | Optimizes the image scans for the General sensor. It is available for the General sensor type only. | `true` | Optional |
`qualys.args.disableImageScan` | Disables the image scans for the General sensor. | `false` | Optional |
`qualys.args.performScaScan` | SCA scanning will be performed for container images. | `false` | Optional |
`qualys.args.disallowInternetAccessForSca` | Internet access is enabled for the SCA scan and the SCA scan is performed in online mode. | `false` | Optional |
`qualys.args.performSecretDetection` | Secret scanning will be performed for container images. | `false` | Optional |
`qualys.args.performMalwareDetection` | Malware scanning will be performed for container images. | `false` | Optional |
`qualys.args.limitResourceUsage` | Used to limit the usage of resources for SCA or Secret or Malware Scan. | `false` | Optional |
`qualys.args.scaScanTimeoutInSeconds` | Specify the SCA scan timeout in seconds. | `900` | Optional |
`qualys.args.insecureRegistry` | Used in case self sign certs are not being configured for private registries in containerd | `false` | Optional |
`qualys.args.enableStorageDriver` | Used in case of containerd overlay storage driver | `true` | Optional |
`qualys.args.storageDriverType` | Specify the containerd overlay storage driver | `overlay` | Optional |
`qualys.args.scanningPolicy` | Specify the scanning policy. Valid values for scanningPolicy are: "DynamicWithStaticScanningAsFallback", "DynamicScanningOnly", "StaticScanningOnly" | `DynamicWithStaticScanningAsFallback` | Optional |
`qualys.args.tagSensorProfile` | Specify the valid tags for Sensor profile. e.g.: "tag1,tag2" | `-` | Optional |
`qualys.args.disableContainerScan` | Disables the container scans for the General sensor. | `false` | Optional |
`qualys.args.enableDiskSpaceCheck` | Set to true, if you want to enable disk space check to perform Static, SCA, Secret or Malware scan | `false` | Optional |
`qualys.args.disableFeatures` | Specify the features to be disabled. Valid values for DisableFeatures are: "SBOM" | `-` | Optional |
`qualys.args.populateK8sMetadata` | Set to true, if you want to populate the Kubernetes cluster metadata as soon as the vulnerabilities are available. | `false` | Optional |
`qualys.args.ignoreExclusionListForImages` | Set to true, if you want to scan the blacklisted images. | `false` | Optional |
`qualys.args.disableProcessEnvCollection` | Set to true, if you want to disable process environment collection during scanning | `false` | Optional |
`qualys.args.disableDefaultLoggingToFile` | Set to true, if you want to disable duplicate logging when enableConsoleLogs is true. | `false` | Optional |
`qualys.args.javaDBUpdateIntervalInDays` | Specify the java DB update interval in days. | `15` | Optional (Compatible only with Sensor 1.39.0-1 and above) |
`qualys.args.assetTrackingFlushDurationInSeconds` | Specify the duration in seconds to flush messages. | `60` | Optional (Compatible only with Sensor 1.39.0-1 and above) |
`qualys.args.assetTrackingFlushThresholdCount` | Specify the threshold count of queue to flush messages. | `20` | Optional (Compatible only with Sensor 1.39.0-1 and above) |
`qualys.readOnly` | Runs the sensor in read-only mode. | `-` | Optional |
`qualys.tolerations.enabled` | Allows the DaemonSet runnable on master nodes. | `false` | Optional |
`qualys.tolerations.toleration` | Add toleration to schedule pod with matching taints. | `-` | Optional |
`qualys.proxy.enabled` | Set to true, if a proxy is required to connect to the Qualys cloud. | `false` | Optional |
`qualys.proxy.proxyvalue` | Specify the IPv4/IPv6 address or FQDN of the proxy server. | `-` | Optional |
`qualys.proxy.proxycertpath` | Specify the path of the proxy certificate file. proxycertpath is applicable only if the proxy has a valid certificate file. | `-` | Optional |
`qualys.sensorContResources.enabled` | Specifies the resources for the Sensor container. | `false` | Optional |
`qualys.sensorContResources.limits.cpu` | Specify the CPU limit for the sensor container. | `500m` | Optional |
`qualys.sensorContResources.limits.memory` | Specify the memory limit for the sensor container. | `500Mi` | Optional |
`qualys.sensorContResources.requests.cpu` | Specify the CPU request for the sensor container. | `100m` | Optional |
`qualys.sensorContResources.requests.memory` | Specify the memory request for the sensor container. | `300Mi` | Optional |
`qualys.scanningContResources.enabled` | Specifies the resources for the scanning container. | `false` | Optional |
`qualys.scanningContResources.limits.cpu` | Specify the CPU limit for the scanning container. | `200m` | Optional |
`qualys.scanningContResources.limits.memory` | Specify the memory limit for the scanning container. | `800Mi` | Optional |
`qualys.scanningContResources.requests.cpu` | Specify the CPU request for the scanning container. | `100m` | Optional |
`qualys.scanningContResources.requests.memory` | Specify the memory request for the scanning container. | `300Mi` | Optional |
`qualys.persistentvolhostpath` | Specify the directory where the sensor will store the files. | `/usr/local/qualys/sensor/data` | Optional |
`qualys.persistentVolumeClaim.enabled` | Requests for a storage of a specific size from the gross persistent volume. | `false` | Optional |
`qualys.persistentVolumeClaim.storageClassName` | Specify the storage class name used by Kubernetes PersistentVolume. | `-` | Mandatory  if `qualys.persistentVolumeClaim.enabled` is `true` |
`qualys.persistentVolumeClaim.storage` | Specify the storage memory required. For example, 1Gi for the general/cicd sensor and 10Gi for the registry sensor. | `-` | Mandatory  if `qualys.persistentVolumeClaim.enabled` is `true` |
`qualys.priorityClass.enabled` | Set to true, if you want to use the priority and preemption on PODs. | `false` | Optional |
`qualys.priorityClass.priorityClassName` | Specify the priority class name used in DaemonSet. | `-` | Optional |
`qualys.priorityClass.priorityClassValue` | Specify the value that determines the priority. For example, "1000000". Enter an integer less than or equal to 1 billion (1000000000). The higher the value, the higher the priority. Values are relative to the values of other priority classes in the cluster. Reserve very high numbers for system critical pods that you don't want to be preempted (removed). | `-` | Optional |
`qualys.priorityClass.preemptionPolicy` | Specify the preemption policy for a POD. | `-` | Optional |
`containerd.secret` | Set to true, when using self-signed certificate for registry in containerd. Add base 64 encoded content of ca.crt file in cssensor-secret yaml under data section. Also update the registry hostIP in daemonset yaml under volumeMounts for registry-cert-volume. | `false` | Optional |
`tolerations` | Add toleration to schedule qcs sensor with matching taints  | `-` | No |
`nodeSelector` | Set nodeSelector if the qcs sensor needs to be deployed on specific node | `-` | No |
`affinity` | Set nodeAffinity, podAffnity and podAntiAffinity based on requirement | `-` | No |

#### How to specify the parameters?
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

For example,

`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor --namespace qualys --set containerd.enabled=true`

**NOTE**: A command line parameter value takes precedence over the parameter value from values.yaml.

## Namespace Usage and Example

- Create a new custom namespace:
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor -n custom-namespace --create-namespace`

- Use an existing namespace:
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor -n existing_namespace_name`

- Use the default (qualys) namespace:
`helm install qcs-sensor-demo qualys-helm-chart/qcs-sensor -n qualys`

> **Tip**: You can use the default [values.yaml](values.yaml)


---
## Contact
Contact <support@qualys.com> for assistance.

