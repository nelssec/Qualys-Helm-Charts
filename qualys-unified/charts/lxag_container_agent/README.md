# Qualys Cloud Agent Container

[Qualys Cloud Agent Container](https://www.qualys.com/) continuously secure containers from build to runtime.

The installation will deploy the Qualys Cloud Agent Container on each worker node as a daemon set. By default, it assumes `containerd` and `CRI-O` as the default runtimes on `Kubernetes cluster` and `OpenShift Cluster`, respectively. If you are using a different container runtime, provide the appropriate value in the helm chart configuration.

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
`helm install lxagent-demo qualys-helm-chart/lxagent --namespace qualys-agent --create-namespace --set qualys.args.activationId=${ACTIVATIONID},qualys.args.customerId=${CUSTOMERID},qualys.args.providerName=${PROVIDERNAME},qualys.args.serverUri=${SERVER_URI}`
---
- Install on Kubernetes cluster with cri-o runtime
`helm install lxagent-demo qualys-helm-chart/lxagent --namespace qualys-agent --create-namespace --set qualys.args.activationId=${ACTIVATIONID},qualys.args.customerId=${CUSTOMERID},qualys.args.providerName=${PROVIDERNAME},qualys.args.serverUri=${SERVER_URI},crio.enabled=true`
---
- Install on Kubernetes cluster with docker runtime
`helm install lxagent-demo qualys-helm-chart/lxagent --namespace qualys-agent --create-namespace --set qualys.args.activationId=${ACTIVATIONID},qualys.args.customerId=${CUSTOMERID},qualys.args.providerName=${PROVIDERNAME},qualys.args.serverUri=${SERVER_URI},docker.enabled=true`
---
- Install on OpenShift cluster with cri-o runtime (Default)
`helm install lxagent-demo qualys-helm-chart/lxagent --namespace qualys-agent --create-namespace --set qualys.args.activationId=${ACTIVATIONID},qualys.args.customerId=${CUSTOMERID},qualys.args.providerName=${PROVIDERNAME},qualys.args.serverUri=${SERVER_URI},openshift=true,crio.enabled=true`
---

## Upgrading the Release

Use the following command to upgrade the chart:

`helm upgrade [RELEASE] [CHART] [flags]`

Where,

[RELEASE] is the release name.

[CHART] is the chart path.

e.g.

`helm upgrade lxagent-demo qualys-helm-chart/lxagent --namespace qualys-agent`

## Uninstalling the Chart

Use the following command to uninstall the chart:

`helm uninstall RELEASE_NAME [...] [flags]`

e.g.

`helm uninstall lxagent-demo --namespace qualys`

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
`docker.enabled` | Set to true, if the container runtime is docker. | `false` | **Important**: Enable only one runtime environment. |
`docker.socketPath` | The host path of the mounted volume for the docker socket. | `/var/run/docker.sock` | Optional |
`docker.tlsVerify.enabled` | Enables the TLS authentication. The value should be 0 or 1. | `false` | Optional |
`docker.tlsVerify.tlsCertPath` | Provide the path of the client certificate directory. | `-` | Optional (Mandatory if DOCKER_TLS_VERIFY=1 is defined). |
`docker.tlsVerify.dockerHost` | Specify the address on which the docker daemon is configured to listen. | `-` | Optional (Mandatory if DOCKER_TLS_VERIFY=1 is defined). |
`docker.tlsVerify.dockerHostValue` | Specify the loopback IPv4 address or hostname, and port <IPv4 address or hostname>:<port#>. | `-` | Optional |
`openshift` | Set to true, if deploying in OpenShift. | `false` |
`qualys.createNamespace` | Set to true, if you want to create new custom namespace. | `false` | Optional |
`qualys.namespace` | Provide the namespace to be used. | `qualys` | Optional `Use the same namespace in values.yaml and on command line when using the helm install command. Check the examples at the bottom of this page.` |
`qualys.customerID` | Provide the Qualys customer id. | `-` | Mandatory |
`qualys.activationID` | Provide the Qualys activation id. | `-` | Mandatory |
`qualys.pod_url` | Provide the URL of a Qualys POD. | `-` | Mandatory |
`qualys.containerLaunchTimeout` | Specify the launch timeout for the scanning container in minutes. | `10` | Optional |
`qualys.image` | Specify the name of the Qualys Cloud Agent image in the private/dockerhub registry. | `qualys/lxagent:1.0.0-0` | Optional |
`qualys.imagePullPolicy` | Specify how to pull (download) the specified image. | `IfNotPresent` | Optional |
`qualys.cpu` | Specify the CPU usage limit in percentage for the lxagent. Valid range: 0-100. | `0.2 (20% per core on the host)` | Optional |
`qualys.args.withoutPersistentStorage` | Runs the lxagent without using the persistent storage on the host. | `false` | Optional |
`qualys.args.enableConsoleLogs` | Prints logs on the console. | `false` | Optional |
`qualys.args.cicdDeployedLxagent` | Run the lxagent in a CI/CD environment. | `false` | Optional |
`qualys.args.registryLxagent` | Run the lxagent to list and scan the registry assets. | `false` | Optional |
`qualys.args.concurrentScan` | Specify the number of docker/registry asset scans to run in parallel. Valid range: 1-20. | `4` | Optional |
`qualys.args.disableLog4jScanning` | Disables the log4j vulnerability scanning for container images. | `false` | Optional |
`qualys.args.disableLog4jStaticDetection` | Disables the log4j static detection for dynamic/static image scans. | `false` | Optional |
`qualys.args.logFilePurgeCount` | The maximum number of lxagent log files to archive. | `5` | Optional |
`qualys.args.logFileSize` | The maximum size for a lxagent log file in bytes. You can specify "<digit><K/M/>", where K is kilobytes and M is megabytes. | `10M` | Optional |
`qualys.args.logLevel` | Sets the logging level for lxagent. It determines the type of lxagent data you want to log. Specify a value from 0 to 5. 0=FATAL, 1=ERROR, 2=WARNING, 3=INFORMATION, 4=VERBOSE, 5=TRACE | `3 (INFORMATION)` | Optional |
`qualys.args.maskEnvVariable` | Masks the environment variables for images and containers. | `false` | Optional |
`qualys.args.optimizeImageScans` | Optimizes the image scans for the General lxagent. It is available for the General lxagent type only. | `false` | Optional |
`qualys.args.disableImageScan` | Disables the image scans for the General lxagent. | `false` | Optional |
`qualys.args.performScaScan` | SCA scanning will be performed for container images. | `false` | Optional |
`qualys.args.disallowInternetAccessForSca` | Internet access is enabled for the SCA scan and the SCA scan is performed in online mode. | `false` | Optional |
`qualys.args.performSecretDetection` | Secret scanning will be performed for container images. | `false` | Optional |
`qualys.args.performMalwareDetection` | Malware scanning will be performed for container images. | `false` | Optional |
`qualys.args.limitResourceUsage` | Used to limit the usage of resources for SCA or Secret or Malware Scan. | `false` | Optional |
`qualys.args.scaScanTimeoutInSeconds` | Specify the SCA scan timeout in seconds. | `900` | Optional |
`qualys.args.insecureRegistry` | Used in case self sign certs are not being configured for private registries in containerd | `false` | Optional |
`qualys.args.storageDriverType` | Used in case of containerd overlay storage driver | `false` | Optional |
`qualys.readOnly` | Runs the lxagent in read-only mode. | `-` | Optional |
`qualys.tolerations.enabled` | Allows the DaemonSet runnable on master nodes. | `false` | Optional |
`qualys.tolerations.toleration.key` | Specify the toleration key. | `-` | Optional |
`qualys.tolerations.toleration.operator` | Specify the toleration operator. | `-` | Optional |
`qualys.tolerations.toleration.value` | Specify the toleration value. | `-` | Optional |
`qualys.tolerations.toleration.effect` | Specify the toleration effect. | `-` | Optional |
`qualys.proxy.enabled` | Set to true, if a proxy is required to connect to the Qualys cloud. | `false` | Optional |
`qualys.proxy.proxyvalue` | Specify the IPv4/IPv6 address or FQDN of the proxy server. | `-` | Optional |
`qualys.proxy.proxycertpath` | Specify the path of the proxy certificate file. proxycertpath is applicable only if the proxy has a valid certificate file. | `-` | Optional |
`qualys.LxagentContResources.enabled` | Specifies the memory resources for the lxagent container. | `false` | Optional |
`qualys.LxagentContResources.memoryLimit` | Specify the memory usage limit for the lxagent container. | `-` | Optional |
`qualys.LxagentContResources.memoryRequest` | Specify the memory usage request for the lxagent container. | `-` | Optional |
`qualys.scanningContResources.enabled` | Specifies the memory resources for the scanning container. | `false` | Optional |
`qualys.scanningContResources.memoryLimit` | Specify the memory usage limit for the scanning container. | `-` | Optional |
`qualys.scanningContResources.memoryRequest` | Specify the memory usage request for the scanning container. | `-` | Optional |
`qualys.persistentvolhostpath` | Specify the directory where the lxagent will store the files. | `/usr/local/qualys/cloud-agent/data` | Optional |
`qualys.persistentVolumeClaim.enabled` | Requests for a storage of a specific size from the gross persistent volume. | `false` | Optional |
`qualys.persistentVolumeClaim.storageClassName` | Specify the storage class name used by Kubernetes PersistentVolume. | `-` | Mandatory  if `qualys.persistentVolumeClaim.enabled` is `true` |
`qualys.persistentVolumeClaim.storage` | Specify the storage memory required. For example, 1Gi for the general/cicd lxagent and 10Gi for the registry lxagent. | `-` | Mandatory  if `qualys.persistentVolumeClaim.enabled` is `true` |
`qualys.priorityClass.enabled` | Set to true, if you want to use the priority and preemption on PODs. | `false` | Optional |
`qualys.priorityClass.priorityClassName` | Specify the priority class name used in DaemonSet. | `-` | Optional |
`qualys.priorityClass.priorityClassValue` | Specify the value that determines the priority. For example, "1000000". Enter an integer less than or equal to 1 billion (1000000000). The higher the value, the higher the priority. Values are relative to the values of other priority classes in the cluster. Reserve very high numbers for system critical pods that you don't want to be preempted (removed). | `-` | Optional |
`qualys.priorityClass.preemptionPolicy` | Specify the preemption policy for a POD. | `-` | Optional |
`qualys.priorityClass.globalDefault` | Indicates that the value of this PriorityClass should be used for PODs without a priorityClassName. | `-` | Optional |
`containerd.secret` | Set to true, when using self-signed certificate for registry in containerd. Add base 64 encoded content of ca.crt file in lxagent-secret yaml under data section. Also update the registry hostIP in daemonset yaml under volumeMounts for registry-cert-volume. | `false` | Optional |

#### How to specify the parameters?
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

For example,

`helm install lxagent-demo qualys-helm-chart/lxagent --namespace qualys --set containerd.enabled=true`

**NOTE**: A command line parameter value takes precedence over the parameter value from values.yaml.

## Namespace Usage and Example

- Create a new custom namespace:
`helm install lxagent-demo qualys-helm-chart/lxagent --set qualys.createNamespace=true --set qualys.namespace=namespace_name -n namespace_name --create-namespace`

- Use an existing namespace:
`helm install lxagent-demo qualys-helm-chart/lxagent --set qualys.namespace=existing_namespace_name -n existing_namespace_name`

- Use the default (qualys) namespace:
`helm install lxagent-demo qualys-helm-chart/lxagent -n qualys`

> **Tip**: You can use the default [values.yaml](values.yaml)


---
## Contact
Contact <support@qualys.com> for assistance.
