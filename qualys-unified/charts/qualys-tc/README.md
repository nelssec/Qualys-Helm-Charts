# Qualys Container Security Unified Helm Chart

Copyright 2024 by Qualys, Inc. All Rights Reserved.
Qualys/qualys and the Qualys logo are registered trademarks of Qualys, Inc. All other trademarks are the property of their respective owners.

The Unified helm chart to deploy the following applications.

- **cluster-sensor**  (Qualys Cluster Sensor)
- **admission-controller** (Qualys Admission Controller)
- **qcs-sensor** (Qualys Container Security Sensor)
- **runtime-sensor**  (Qualys Runtime Sensor)

## Application Version Compatibility
| Helm Chart(qualys-tc) version | cluster-sensor image version | qcs-sensor image version | admission-controller image version   | runtime-sensor image version
|-------------------|------------------------|--------------------|--------------------------------------|-----------------------------|
| 2.6.1             | 1.3.0-0,1.2.1-0,1.2.0-0 | 1.37.0-0, 1.38.0-1, 1.39.0-1, 1.40.1-0 | 1.0.0-6, 1.0.0-11, 1.1.0-17, 1.1.1-0 | 1.3.0-0
| 2.6.0             | 1.3.0-0,1.2.1-0,1.2.0-0 | 1.37.0-0, 1.38.0-1, 1.39.0-1, 1.40.1-0 | 1.0.0-6, 1.0.0-11, 1.1.0-17, 1.1.1-0 | 1.3.0-0
| 2.5.1             | 1.2.1-0,1.2.0-0 | 1.36.1-0, 1.37.0-0, 1.38.0-1, 1.39.0-1 | 1.0.0-6, 1.0.0-11, 1.1.0-17, 1.1.1-0 | 1.2.0-0
| 2.4.1             | 1.2.0-0 | 1.35.0-0, 1.36.1-0, 1.37.0-0, 1.38.0-1 | 1.0.0-6, 1.0.0-11, 1.1.0-17          | 1.0.1-0, 1.1.0-0, 1.1.1-0
| 2.4.0             | 1.2.0-0 | 1.35.0-0, 1.36.1-0, 1.37.0-0, 1.38.0-1 | 1.0.0-6, 1.0.0-11, 1.1.0-17          | 1.0.1-0, 1.1.0-0, 1.1.1-0
| 2.3.2             | 1.1.0-0, 1.1.1-0,1.1.2-0 | 1.35.0-0, 1.36.1-0, 1.37.0-0 | 1.0.0-6, 1.0.0-11, 1.1.0-17          | 1.0.1-0, 1.1.0-0, 1.1.1-0
| 2.3.1             | 1.1.0-0, 1.1.1-0,1.1.2-0 | 1.35.0-0, 1.36.1-0, 1.37.0-0 | 1.0.0-6, 1.0.0-11, 1.1.0-17          | 1.0.0-0, 1.0.1-0, 1.1.0-0
| 2.3.0             | 1.1.0-0, 1.1.1-0,1.1.2-0 | 1.34.3-0, 1.35.0-0, 1.36.1-0 | 1.0.0-6, 1.0.0-11, 1.1.0-17          | 1.0.0-0, 1.0.1-0, 1.1.0-0
| 2.2.0             | 1.1.0-0, 1.1.1-0 | 1.34.3-0, 1.35.0-0, 1.36.1-0 | 1.0.0-6, 1.0.0-11, 1.1.0-17          | 1.0.0-0, 1.0.1-0
| 2.1.1             | 1.1.0-0, 1.1.1-0 | 1.34.1-0, 1.34.3-0, 1.35.0-0 | 1.0.0-6, 1.0.0-11                    | 1.0.0-0, 1.0.1-0
| 2.1.0             | 1.1.0-0, 1.1.1-0 | 1.33.0-0, 1.34.1-0, 1.34.3-0 | 1.0.0-6, 1.0.0-11                    | 1.0.0-0, 1.0.1-0
| 2.0.4             | 1.1.0-0, 1.1.1-0 | 1.33.0-0, 1.34.1-1, 1.34.3-0 | 1.0.0-6                              | 1.0.0-0
| 2.0.3	            | 1.1.0-0, 1.1.1-0 | 1.33.0-0, 1.34.1-1 | 1.0.0-6                              | 1.0.0-0
| 2.0.2             | 1.1.0-0, 1.1.1-0 | 1.33.0-0, 1.34.1-0 | 1.0.0-6                              | 1.0.0-0
| 2.0.1             | 1.1.0-0, 1.1.1-0 | 1.33.0-0 | 1.0.0-6                              | 1.0.0-0
| 2.0.0             | 1.1.0-0 | 1.33.0-0 | 1.0.0-6                              | NA
| 1.0.4             | 1.0.0-0 | 1.33.0-0 | 1.0.0-6                              | NA
| 1.0.3             | 1.0.0-0 | 1.33.0-0 | 1.0.0-6                              | NA
| 1.0.2             | 1.0.0-0 | 1.33.0-0 | 1.0.0-6                              | NA
| 1.0.1             | 1.0.0-0 | 1.33.0-0 | 1.0.0-6                              | NA
| 1.0.0             | 1.0.0-0 | 1.33.0-0 | 1.0.0-6                              | NA

### NOTE:
For the supported QCS Sensor versions on **GKE Autopilot**, please refer to the interoperability matrix:
[CS Interoperability Matrix](https://docs.qualys.com/en/cs/latest/get_started/container_security_interoperability_matrix.htm)

## Prerequisites

### Kubernetes & Helm

- Kubernetes 1.26+
- Helm v3.10.x
- OpenShift v4.0+ (Default Container Engine is CRI-O)

### Get Repository Info

- `helm repo add qualys-helm-chart https://qualys.github.io/Qualys-Helm-Charts/`
- `helm repo update`

### Know Your Runtime (Required for qcs-sensor)

Get the details about the container runtime by executing the following command:

`kubectl get nodes -o wide`

## Configuration

Configuration includes global paramaters that are common across all application and application's config parameters

### Global parameters

| Parameter             | Description      | Default | Mandatory | Notes 
| --------------------- | ---------------- | ------- | --------- | ------- 
| `global.customerId`   | Unique customer id associated with customer's account | Empty   | Yes | 
| `global.activationId` | Unique activation id associated with customer's account | Empty   | Yes | 
| `global.gatewayUrl`   | Specify Qualys Platform (POD) gateway URL for backend communication | Empty   | Yes (`Applicable for cluster-sensor, runtime-sensor and admission-controller installation`) | 
| `global.cmsqagPublicUrl`   | Provide the cmsqagpublic URL of a Qualys POD | Empty   | Yes (`Applicable for qcs-sensor installation`) | 
| `global.imagePullSecret` | Provide the image pull secret | Empty | No |
| `global.clusterInfoArgs.cloudProvider` | Name of Cloud provider | Empty | Yes |  E.g. (AWS,GCP,AZURE,OCI,SELF_MANAGED_K8S)
| `global.clusterInfoArgs.AWS.arn` | Provide value of arn | Empty | Yes if `global.clusterInfoArgs.cloudProvider=AWS` | E.g. arn:aws:eks:\<region>:\<accountid>:cluster:\<clustername>
| `global.clusterInfoArgs.AZURE.id` | Provide value of id | Empty | Yes if `global.clusterInfoArgs.cloudProvider=AZURE` | E.g. /subscriptions/<subscription_id>/resourcegroups/NK_test/providers/Microsoft.ContainerService/managedClusters/<cluster_name>
| `global.clusterInfoArgs.AZURE.region` | Provide value of region | Empty | Yes if `global.clusterInfoArgs.cloudProvider=AZURE` |
| `global.clusterInfoArgs.GCP.krn` | Provide value of krn | Empty | Yes if `global.clusterInfoArgs.cloudProvider=GCP` | E.g. projects/<project_id>/locations/\<region>/clusters/<cluster_name>
| `global.clusterInfoArgs.OCI.ocid` | Provide value of ocid | Empty | Yes if `global.clusterInfoArgs.cloudProvider=OCI` | E.g. ocid1.cluster.oc1.\<REGION>.\<CLUSTER_OCID>
| `global.clusterInfoArgs.OCI.clusterName` | Provide cluster name | Empty | Yes if `global.clusterInfoArgs.cloudProvider=OCI` |
| `global.clusterInfoArgs.SELF_MANAGED_K8S.clusterName` | Provide cluster name | Empty | Yes if `global.clusterInfoArgs.cloudProvider=SELF_MANAGED_K8S` |
| `global.rootCA.certificate` | Provide custom certificate in base64 encoded format to connect with qualys backend if required| Empty | No | E.g: `global.rootCA.certificate=$(cat <path-of-cert-file> \| base64 \| tr -d '\n')`
| `global.proxy.value` | Url of proxy server | Empty | No | Format: `"http://<proxy FQDN or Ip address>:<port>"` E.g. http://127.0.0.1:8080 
| `global.proxy.certificate` | Provide proxy certificate in base64 encoded format to connect with proxy server if required| Empty | No | E.g: `global.proxy.certificate=$(cat <path-of-cert-file> \| base64 \| tr -d '\n')`
| `global.proxy.skipVerifyTLS` | Skip secure TLS verfication | false | No | 
| `global.openshift` | Set to true, if deploying in OpenShift. | `false` |
| `global.gkeAutopilot.enabled` | Set to true, if deploying in GKE Autopilot. | `false` | No |
| `global.gkeAutopilot.allowlistLabelForQcsSensor` | Set the label value to the WorkloadAllowList name to view detailed error messages. | Empty | No | More details can be found at: https://cloud.google.com/kubernetes-engine/docs/troubleshooting/autopilot-privileged-workloads
| `clusterSensor.enabled`  | enable/disable cluster sensor installation | true | Yes | 
| `admissionController.enabled` | enable/disable admission controller installation | false | Yes,if you want to install Admission controller | 
| `qcsSensor.enabled` | enable/disable qcs sensor installation | false | Yes, if you want to install qcs sensor | 
| `runtimeSensor.enabled` | enable/disable runtime-sensor installation | false | Yes, if you want to install runtime-sensor | 

### Cluster Sensor paramaters

| Parameter                | Description      | Default | Mandatory | Remarks 
| ---------------------    | ---------------- | ------- | --------- | ------- 
| `clusterSensor.image`    | Specify the name of the cluster sensor image in the private/dockerhub registry | qualys/cluster-sensor:1.3.0-0 | No | 
| `clusterSensor.imagePullPolicy` | Pull policy for cluster sensor image | Always | No | Accepted Values: IfNotPresent/Always/Never
| `clusterSensor.persistentStorage.enabled` | Flag to run sensor with or without persistent storage | false | No |
| `clusterSensor.persistentStorage.hostPath` | persistent storage path | /usr/local/qualys/clustersensor/data | No | Set appropriate ownership and permission to cluster sensor user qualys(UID:555) for hostPath E.g. sudo chown 555:555 /usr/local/qualys/clustersensor/data
| `clusterSensor.logConfig.logLevel` | Specify the log level (debug, info, error, warn, fatal) | Empty | No | 
| `clusterSensor.logConfig.logFileSize` | The file is rotated when its size exceeds. File size is in megabytes  | Empty | No | 
| `clusterSensor.logConfig.logPurgeCount` | Maximum number of archived log files  | Empty | No |
| `clusterSensor.resources.limits.cpu` | cpu limit of cluster sensor container | 500m | No | 
| `clusterSensor.resources.limits.memory` | memory limit of cluster sensor container | 750Mi | No | 
| `clusterSensor.resources.requests.cpu` | cpu request of cluster sensor container | 200m | No | 
| `clusterSensor.resources.requests.memory` | memory request of cluster sensor container | 256Mi | No | 
| `clusterSensor.maskEnvVariable` | to enable the masking of environment variables of containers | false | No | 
| `clusterSensor.hostNetwork` | To enable/disable sharing host network namespace and resources with cluster sensor pod | true | No | 
| `clusterSensor.k8sCompliance.enable` | To enable/disable kubernetes compliance scan | true | No | 
| `clusterSensor.hostScanner.enable` | To enable/disable host scanner | true | No | 
| `clusterSensor.hostScanner.runOnMaster` | Set it false to disable running host-scanner on master node | true | No | 
| `clusterSensor.hostScanner.resources.limits.cpu` | cpu limit of host scanner | 100m | No | 
| `clusterSensor.hostScanner.resources.limits.memory` | memory limit of host scanner | 256Mi | No | 
| `clusterSensor.nodeSelector` | Set nodeSelector if the cluster sensor needs to be deployed on specific node |  | No | 
| `clusterSensor.affinity` | Set nodeAffinity, podAffnity and podAntiAffinity based on requirement |  | No | 
| `clusterSensor.tolerations` | Add toleration to schedule cluster sensor with matching taints  |  | No | 

### qcs-sensor parameters

Parameter | Description | Default | Notes
--------- | ----------- | ------- | -----
`qcsSensor.containerd.enabled` | Set to true, if the container runtime is containerd. | `true` | **Important**: Enable only one runtime environment. |
`qcsSensor.containerd.socketPath` | The host path of the mounted volume for the containerd socket. | `/var/run/containerd/containerd.sock` | Optional |
`qcsSensor.containerd.storageDriverPath` | The root directory path of containerd overlay storage driver | `/var/lib/containerd` | Optional |
`qcsSensor.crio.enabled` | Set to true, if the container runtime is CRI-O. | `false` | **Important**: Enable only one runtime environment. |
`qcsSensor.crio.socketPath` | The host path of the mounted volume for the CRI-O socket. | `/var/run/crio/crio.sock` | Optional |
`qcsSensor.crio.storageDriverType` | Specify the crio overlay storage driver type | `overlay` | Optional |
`qcsSensor.docker.enabled` | Set to true, if the container runtime is docker. | `false` | **Important**: Enable only one runtime environment. |
`qcsSensor.docker.socketPath` | The host path of the mounted volume for the docker socket. | `/var/run/docker.sock` | Optional |
`qcsSensor.docker.tlsVerify.enabled` | Enables the TLS authentication. The value should be 0 or 1. | `false` | Optional |
`qcsSensor.docker.tlsVerify.tlsCertPath` | Provide the path of the client certificate directory. | `-` | Optional (Mandatory if DOCKER_TLS_VERIFY=1 is defined). |
`qcsSensor.docker.tlsVerify.dockerHost` | Specify the address on which the docker daemon is configured to listen. | `-` | Optional (Mandatory if DOCKER_TLS_VERIFY=1 is defined). |
`qcsSensor.docker.tlsVerify.dockerHostValue` | Specify the loopback IPv4 address or hostname, and port <IPv4 address or hostname>:<port#>. | `-` | Optional |
`qcsSensor.docker.storageDriverPath` | The root directory path of docker overlay2 storage driver | `/var/lib/docker` | Optional |
`qcsSensor.docker.storageDriverType` |  Specify the docker overlay2 storage driver type | `overlay2` | Optional |
`qcsSensor.qualys.createNamespace` | Set to true, if you want to create new custom namespace. | `false` | Optional |
`qcsSensor.qualys.containerLaunchTimeout` | Specify the launch timeout for the scanning container in minutes. | `10` | Optional |
`qcsSensor.qualys.image` | Specify the name of the Container Security sensor image in the private/dockerhub registry. | `docker.io/qualys/qcs-sensor:1.40.1-0` | Optional |
`qcsSensor.qualys.imagePullPolicy` | Specify how to pull (download) the specified image. | `Always` | Optional |
`qcsSensor.qualys.cpu` | Specify the CPU limit for the sensor container. | `500m` | Optional |
`qcsSensor.qualys.args.withoutPersistentStorage` | Runs the sensor without using the persistent storage on the host. | `false` | Optional |
`qcsSensor.qualys.args.enableConsoleLogs` | Prints logs on the console. | `false` | Optional |
`qcsSensor.qualys.args.cicdDeployedSensor` | Run the sensor in a CI/CD environment. | `false` | Optional |
`qcsSensor.qualys.args.registrySensor` | Run the sensor to list and scan the registry assets. | `false` | Optional |
`qcsSensor.qualys.args.concurrentScan` | Specify the number of docker/registry asset scans to run in parallel. Valid range: 1-20. | `2` | Optional |
`qcsSensor.qualys.args.disableLog4jScanning` | Disables the log4j vulnerability scanning for container images. | `false` | Optional |
`qcsSensor.qualys.args.disableLog4jStaticDetection` | Disables the log4j static detection for dynamic/static image scans. | `false` | Optional |
`qcsSensor.qualys.args.logFilePurgeCount` | The maximum number of sensor log files to archive. | `5` | Optional |
`qcsSensor.qualys.args.logFileSize` | The maximum size for a sensor log file in bytes. You can specify "<digit><K/M/>", where K is kilobytes and M is megabytes. | `10M` | Optional |
`qcsSensor.qualys.args.logLevel` | Sets the logging level for sensor. It determines the type of sensor data you want to log. Specify a value from 0 to 5. 0=FATAL, 1=ERROR, 2=WARNING, 3=INFORMATION, 4=VERBOSE, 5=TRACE | `3 (INFORMATION)` | Optional |
`qcsSensor.qualys.args.maskEnvVariable` | Masks the environment variables for images and containers. | `false` | Optional |
`qcsSensor.qualys.args.optimizeImageScans` | Optimizes the image scans for the General sensor. It is available for the General sensor type only. | `true` | Optional |
`qcsSensor.qualys.args.disableImageScan` | Disables the image scans for the General sensor. | `false` | Optional |
`qcsSensor.qualys.args.performScaScan` | SCA scanning will be performed for container images. | `false` | Optional |
`qcsSensor.qualys.args.disallowInternetAccessForSca` | Internet access is enabled for the SCA scan and the SCA scan is performed in online mode. | `false` | Optional |
`qcsSensor.qualys.args.performSecretDetection` | Secret scanning will be performed for container images. | `false` | Optional |
`qcsSensor.qualys.args.performMalwareDetection` | Malware scanning will be performed for container images. | `false` | Optional |
`qcsSensor.qualys.args.limitResourceUsage` | Used to limit the usage of resources for SCA or Secret or Malware Scan. | `false` | Optional |
`qcsSensor.qualys.args.scaScanTimeoutInSeconds` | Specify the SCA scan timeout in seconds. | `900` | Optional |
`qcsSensor.qualys.args.insecureRegistry` | Used in case self sign certs are not being configured for private registries in containerd | `false` | Optional |
`qcsSensor.qualys.args.enableStorageDriver` | Used in case of containerd overlay storage driver | `true` | Optional |
`qcsSensor.qualys.args.storageDriverType` | Specify the containerd overlay storage driver | `overlay` | Optional |
`qcsSensor.qualys.args.scanningPolicy` | To specify the scanning policy. Valid Values => 'DynamicWithStaticScanningAsFallback', 'DynamicScanningOnly', 'StaticScanningOnly' | `DynamicWithStaticScanningAsFallback` | Optional |
`qcsSensor.qualys.args.tagSensorProfile` | Specify the valid tags for Sensor profile. e.g.: "tag1,tag2" | `-` | Optional |
`qcsSensor.qualys.args.disableContainerScan` | Disables the container scans for the General sensor. | `false` | Optional |
`qcsSensor.qualys.args.enableDiskSpaceCheck` | Set to true, if you want to enable disk space check to perform Static, SCA, Secret or Malware scan | `false` | Optional |
`qcsSensor.qualys.args.disableFeatures` | Specify the features to be disabled. Valid values for DisableFeatures are: "SBOM" | `-` | Optional |
`qcsSensor.qualys.args.populateK8sMetadata` | Set to true, if you want to populate the Kubernetes cluster metadata as soon as the vulnerabilities are available. | `false` | Optional |
`qcsSensor.qualys.args.ignoreExclusionListForImages` | Set to true, if you want to scan the blacklisted images. | `false` | Optional |
`qcsSensor.qualys.args.disableProcessEnvCollection` | Set to true, if you want to disable process environment collection during scanning | `false` | Optional |
`qcsSensor.qualys.args.disableDefaultLoggingToFile` | Set to true, if you want to disable duplicate logging when enableConsoleLogs is true. | `false` | Optional |
`qcsSensor.qualys.args.javaDBUpdateIntervalInDays` | Specify the java DB update interval in days. | `15` | Optional (Compatible only with Sensor 1.39.0-1 and above) |
`qcsSensor.qualys.args.assetTrackingFlushDurationInSeconds` | Specify the duration in seconds to flush messages. | `60` | Optional (Compatible only with Sensor 1.39.0-1 and above) |
`qcsSensor.qualys.args.assetTrackingFlushThresholdCount` | Specify the threshold count of queue to flush messages. | `20` | Optional (Compatible only with Sensor 1.39.0-1 and above) |
`qcsSensor.qualys.readOnly` | Runs the sensor in read-only mode. | `-` | Optional |
`qcsSensor.qualys.tolerations.enabled` | Allows the DaemonSet runnable on master nodes. | `false` | Optional |
`qcsSensor.qualys.tolerations.toleration` | Add toleration to schedule pod with matching taints. | `-` | Optional |
`qcsSensor.qualys.sensorContResources.enabled` | Specifies the resources for the Sensor container. | `false` | Optional |
`qcsSensor.qualys.sensorContResources.limits.cpu` | Specify the CPU limit for the sensor container. | `500m` | Optional |
`qcsSensor.qualys.sensorContResources.limits.memory` | Specify the memory limit for the sensor container. | `500Mi` | Optional |
`qcsSensor.qualys.sensorContResources.requests.cpu` | Specify the CPU request for the sensor container. | `100m` | Optional |
`qcsSensor.qualys.sensorContResources.requests.memory` | Specify the memory request for the sensor container. | `300Mi` | Optional |
`qcsSensor.qualys.sensorContResources.requests.gkeAutoEphemeralStorage` | Specify the ephemeral storage request for sensor container on GKE Autopilot. | 100Mi | Optional |
`qcsSensor.qualys.sensorContResources.limits.gkeAutoEphemeralStorage` | Specify the ephemeral storage limit for sensor container on GKE Autopilot. | 500Mi | Optional |
`qcsSensor.qualys.scanningContResources.enabled` | Specifies the resources for the scanning container. | `false` | Optional |
`qcsSensor.qualys.scanningContResources.limits.cpu` | Specify the CPU limit for the scanning container. | `200m` | Optional |
`qcsSensor.qualys.scanningContResources.limits.memory` | Specify the memory limit for the scanning container. | `800Mi` | Optional |
`qcsSensor.qualys.scanningContResources.requests.cpu` | Specify the CPU request for the scanning container. | `100m` | Optional |
`qcsSensor.qualys.scanningContResources.requests.memory` | Specify the memory request for the scanning container. | `300Mi` | Optional |
`qcsSensor.qualys.persistentvolhostpath` | Specify the directory where the sensor will store the files. | `/usr/local/qualys/sensor/data` | Optional |
`qcsSensor.qualys.persistentVolumeClaim.enabled` | Requests for a storage of a specific size from the gross persistent volume. | `false` | Optional |
`qcsSensor.qualys.persistentVolumeClaim.storageClassName` | Specify the storage class name used by Kubernetes PersistentVolume. | `-` | Mandatory  if `qcsSensor.qualys.persistentVolumeClaim.enabled` is `true` |
`qcsSensor.qualys.persistentVolumeClaim.storage` | Specify the storage memory required. For example, 1Gi for the general/cicd sensor and 10Gi for the registry sensor. | `-` | Mandatory  if `qcsSensor.qualys.persistentVolumeClaim.enabled` is `true` |
`qcsSensor.qualys.priorityClass.enabled` | Set to true, if you want to use the priority and preemption on PODs. | `false` | Optional |
`qcsSensor.qualys.priorityClass.priorityClassName` | Specify the priority class name used in DaemonSet. | `-` | Optional |
`qcsSensor.qualys.priorityClass.priorityClassValue` | Specify the value that determines the priority. For example, "1000000". Enter an integer less than or equal to 1 billion (1000000000). The higher the value, the higher the priority. Values are relative to the values of other priority classes in the cluster. Reserve very high numbers for system critical pods that you don't want to be preempted (removed). | `-` | Optional |
`qcsSensor.qualys.priorityClass.preemptionPolicy` | Specify the preemption policy for a POD. | `-` | Optional |
`qcsSensor.qualys.hostNetwork` | To enable/disable sharing host network namespace and resources with qcs sensor pod | true | No | 
`qcsSensor.nodeSelector` | Set nodeSelector if the qcs sensor needs to be deployed on specific node |  | No | 
`qcsSensor.affinity` | Set nodeAffinity, podAffnity and podAntiAffinity based on requirement |  | No | 
`qcsSensor.tolerations` | Add toleration to schedule qcs sensor with matching taints  |  | No | 

### admission controller parameters

| Parameter                                                     | Description                                                                                                                                           | Default                                    | Mandatory      | Remarks 
|---------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|----------------| ------- 
| `admissionController.enabled`                                 | Specify the to enable Admission Controller                                                                                                            | false                                      | Yes            |
| `admissionController.logging.file.name`                       | Specify the name of the log file                                                                                                                      | admissionController.log                    | No             |
| `admissionController.logging.file.rotation.enabled`           | Enables Log file rotation. Old log files are archived                                                                                                 | true                                       | No             | The archived file name follows the path:admissionController-2023-09-28T19-29-04.072.log.gz  The suffix is the time at which the log file is archived
| `admissionController.logging.file.rotation.maxSize`           | Specify the maximum size of the log file at which point the log file is archived                                                                      | 100MB                                      | No             |
| `admissionController.logging.file.rotation.maxBackups`        | Specify the maximum number of backups to keep. This will delete older archives from the disk.                                                         | 4                                          | No             |
| `admissionController.logging.file.rotation.maxAge`            | Specify the  maximum age in days to retain the old log files based on timestamp encoded in their filename.                                            | 180 days                                   | No             |
| `admissionController.logging.file.rotation.compress`          | Specify to compress old (archived) log files                                                                                                          | true                                       | No             | Uses Gunzip compression to compress the log files.
| `admissionController.syncInterval`                            | Specify the sync interval with backend (gateway)                                                                                                      | 15                                         | No             |
| `admissionController.platformSyncInterval`                    | Specify the k8s cluster node info (OS/Architecture) read frequency                                                                                    | 5                                          | No             |
| `admissionController.persistentStorage.enabled`               | Enables Persistent storage                                                                                                                            | false                                      | No             | This is used for writing log files to a persistent storage. This can be either a persistent volume claim or path on the k8s (worker) node.
| `admissionController.persistentVolumeHostPath`                | Specify the HostPath on k8s worker node that is used as Persistent storage.                                                                           | /usr/local/qualys/admissionController/data | No             | This will be used as fallback if 'admissionController.persistentVolumeClaim.enabled' is false and 'admissionController.persistentStorage.enabled' is true.
| `admissionController.persistentVolumeClaim.enabled`           | Enables Persistent volume claim                                                                                                                       | false                                      | No             |
| `admissionController.persistentVolumeClaim.storageClassName	` | Specify the K8s Storage class name for the PVC                                                                                                        | Empty                                      | No             |
| `admissionController.persistentVolumeClaim.storageSize`       | Specify the K8s Storage size for the PVC                                                                                                              | Empty                                      | No             |
| `admissionController.persistentVolumeClaim.accessModes`       | Specify the K8s Storage access modes for the PVC                                                                                                      | ReadWriteOnce                              | No             |
| `admissionController.enforcementAction`                       | Specify the AUDIT/BLOCK Passthrough mode                                                                                                              | AUDIT                                      | No             |
| `admissionController.serviceAccount.name`                     | Specify the name of the service account for the admission controller deployment                                                                       | admissionController-qualys-sa              | No             |
| `admissionController.serviceAccount.create`                   | Enable or Disable creation of service account.                                                                                                        | true                                       | No             | If disabled, the customer has to specify a service account with sufficient privileges for admission controller to function correctly. Recommended not to disable this, only for advanced cases.
| `admissionController.registry.config.name`                    | Specify the name of the K8s ConfigMap that refers to registry configuration.                                                                          | qualys-registry-config                     | No             |
| `admissionController.registry.config.filename`                | Specify the name of the registry configuration file inside the container.                                                                             | registry-config.yaml                       | No             |
| `admissionController.registry.config.fileContent`             | Specify the config --set admissionController.registry.config.fileContent=`cat /path/to/registry-config.yaml                                           | Empty                                      | Yes            |
| `admissionController.nameOverride`                            | Specify the name for the deployment.                                                                                                                  | admissionController                        | No             | Recommended not to change this as if it is changed, the self-signed certs need to follow the same name in its FQDN
| `admissionController.fullnameOverride`                        | Specify the Helm release name.                                                                                                                        | admissionController                        | No             |
| `admissionController.certificateFilePath`                     | Specify the  path of the ssl server certificate inside the container                                                                                  | /etc/certs/server.crt                      | No             |
| `admissionController.certificateKeyPath`                      | Specify the  path of the ssl server certificate key  inside the container                                                                             | /etc/certs/server.key                      | No             |
| `admissionController.port`                                    | Specify the port of the admission controller server.                                                                                                  | 8443                                       | No             |
| `admissionController.configPathDir`                           | Specify the directory path of configuration files inside the container                                                                                | /etc/config                                | No             |
| `admissionController.configFile`                              | Specify the configuration file name inside the container                                                                                              | config.yaml                                | No             |
| `admissionController.certs.secretName`                        | Specify the optional, name of kubernetes secret containing the cert                                                                                   | admissionController-certs                  | No             |
| `admissionController.certs.serverCertificate`                 | Specify the Certificate file for admission webhook server to use.                                                                                     | Empty                                      | Yes            | Should be in base64 encoded format of the Server cert in PEM format. e.g:--set admissionController.certs.serverCertificate=`cat /path/to/certs/server.crt | base64 | tr -d '\n'` \
| `admissionController.certs.serverKey`                         | Specify the Certificate Key file for admission webhook server to use.                                                                                 | Empty                                      | Yes            | Should be in base64 encoded format of the Server cert's key in PEM format. e.g.:--set admissionController.certs.serverKey=`cat /path/to/certs/server.key | base64 | tr -d '\n'` \
| `admissionController.webhook.caBundle`                        | Specify the Certificate Authority file for admission webhook server to use.                                                                           | Empty                                      | Yes            | Should be in base64 encoded format of the Certificate Authority in PEM format. e.g.:--set admissionController.webhook.caBundle=`cat /path/to/certs/ca.crt | base64 | tr -d '\n'` \
| `admissionController.webhook.failurePolicy`                   | Specify the K8s webhook configuration property that decides to allow or reject a request in case of the admission webhook (or qualys backend) failure. | Ignore                                     | No             | Possible values : Ignore or Fail
| `admissionController.webhook.timeoutSeconds`                  | Specify the K8s webhook configuration timeout property that mark the request as failed                                                                | 30                                         | No             |
| `admissionController.resources.replicas`                      | Specify the number of replicas of container required                                                                                                  | 1                                          | No             |
| `admissionController.resources.limits.enabled`                | Enables or disables limits                                                                                                                            | true                                       | No             |
| `admissionController.resources.limits.cpu`                    | Specify the container cpu limit                                                                                                                       | 200m                                       | No             |
| `admissionController.resources.limits.memory`                 | Specify the container memory limit                                                                                                                    | 256Mi                                      | No             |
| `admissionController.resources.requests.enabled`              | Enables or disables limits                                                                                                                            | true                                       | No             |
| `admissionController.resources.requests.cpu`                  | Specify the container cpu requests                                                                                                                    | 100m                                       | No             |
| `admissionController.resources.requests.memory`               | Specify the container memory requests	                                                                                                                | 256Mi                                      | No             |
| `admissionController.dataRetention.inDays`                    | Specify the data retention period of (failed) admission review records in the admission controller container.                                         | 30                                         | No             | Currently used for Debugging purposes only.
| `admissionController.dataRetention.scheduleInDays`            | Specify the frequency of the retention job to purge the failed admission review records in the admission controller container.                         | 1 Day                                      | No        |                                                                                                                                                                                                 |
| `admissionController.image`                                   | Specify the name of the admission controller image in the private/dockerhub registry                                                                   | qualys/admission-controller:1.1.1-0        | No        |                                                                                                                                                                                                 |
| `admissionController.imagePullPolicy`                         | Pull policy for admission controller image                                                                                                             | Always                                     | No        | Accepted Values: IfNotPresent/Always/Never                                                                                                                                                      |
| `admissionController.nodeSelector` | Set nodeSelector if the admission controller needs to be deployed on specific node |                                            | No | 
| `admissionController.affinity` | Set nodeAffinity, podAffnity and podAntiAffinity based on requirement |                                            | No | 
| `admissionController.tolerations` | Add toleration to schedule admission controller with matching taints  |                                            | No | 
| `admissionController.logging.level` | Specify the log level (debug, info, error, warn, fatal) | info | no |

### Runtime Sensor paramaters

| Parameter                | Description      | Default | Mandatory | Remarks 
| ---------------------    | ---------------- | ------- | --------- | ------- 
| `runtimeSensor.image`    | Specify the name of the runtime-sensor image in the private/dockerhub registry | qualys/runtime-sensor:1.3.0-0 | No |
| `runtimeSensor.imagePullPolicy` | Pull policy for runtime-sensor image | Always | No | Accepted Values: IfNotPresent/Always/Never
| `runtimeSensor.logConfig.logLevel` | Specify the log level (debug, info, error, warn, fatal) | info | No | 
| `runtimeSensor.logConfig.logFileSize` | The file is rotated when its size exceeds. File size is in megabytes | 10 | No | 
| `runtimeSensor.logConfig.logPurgeCount` | Maximum number of archived log files  | 5 | No |
| `runtimeSensor.hostNetwork` | To enable/disable sharing host network namespace and resources with runtime-sensor pod | true | No | 
| `runtimeSensor.hostProc` | To enable/disable mounting host /proc in runtime-sensor pod | true | No | 
| `runtimeSensor.enableDebugPolicy` | To enable/disable debug policy | false | No | 
| `runtimeSensor.ignoreProcess` | List of comma separated process paths, whose events are to be ignored. | Empty | No | e.g. /usr/bin/snap
| `runtimeSensor.processAllowList.enabled` | Flag to run sensor with or without alllowed process list | true | No |
| `runtimeSensor.processAllowList.value` | List of comma separated regex, which are allowed. | Empty | No | e.g. Allowed process list required for runtime-sensor threat detection - /*/(curl|wget|clang|bcc|gcc|docker|unshare|mount|kubectl|crictl|modprobe|pnscan|masscan|wpscan|nmap|zgrab|nslookup|netstat|ifconfig|ping|traceroute|route|tcpdump|python|crontab|service|sysctl|rm|nc|ip|arp)$,^(/dev/fd/|/run/shm/|/dev/shm/)
| `runtimeSensor.resources.limits.cpu` | CPU limit for runtime-sensor container | 500m | No | 
| `runtimeSensor.resources.limits.memory` | Memory limit for runtime-sensor container | 2048Mi | No | 
| `runtimeSensor.resources.requests.cpu` | CPU request for runtime-sensor container | 500m | No | 
| `runtimeSensor.resources.requests.memory` | Memory request for runtime-sensor container | 2048Mi | No | 
| `runtimeSensor.persistentStorage.enabled` | Flag to run sensor with or without persistent storage | false | No |
| `runtimeSensor.persistentStorage.hostPath` | Persistent storage path | /usr/local/qualys/runtime-sensor/data | No | 
| `runtimeSensor.nodeSelector` | Set nodeSelector if the runtime sensor needs to be deployed on specific node |  | No | 
| `runtimeSensor.affinity` | Set nodeAffinity, podAffnity and podAntiAffinity based on requirement |  | No | 
| `runtimeSensor.tolerations` | Add toleration to schedule runtime sensor with matching taints  |  | No | 

#### How to specify the parameters?
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

For example,

`helm install qualys-tc qualys-helm-chart/qualys-tc --namespace qualys --set global.customerId="xxx"`

**NOTE**: A command line parameter value takes precedence over the parameter value from values.yaml.

> **Tip**: You can use the default [values.yaml](values.yaml)

## Usage

## Installing the helm chart

### How to install cluster sensor
Below command will install cluster sensor by default. You can set mandatory parameter either using values.yaml or --set argument of helm.   
E.g.   

---
    helm install qualys-tc qualys-helm-chart/qualys-tc --namespace qualys --create-namespace --set global.customerId=<customer id>,global.activationId=<activation id>,global.gatewayUrl=<gateway Url>,global.clusterInfoArgs.cloudProvider=SELF_MANAGED_K8S,global.clusterInfoArgs.SELF_MANAGED_K8S.clusterName=<cluster name>  
---

If your installation is on kubernetes platforms of managed cloud providers AWS/GCP/Azure/OCI then kindly set
global.clusterInfoArgs.cloudProvider and its mandatory parameters accordingly.  

Please go through <https://docs.qualys.com/en/cluster-sensor/latest/get_started/get_started.htm> for detailed instructions.  

Note: Installation of Cluster Sensor by Unified Helm chart(qualys-tc) is enabled by default, you can disable it using clusterSensor.enabled=false if needed. 

### How to install  Qualys Container Security Sensor (qcs sensor)
Below command will only install qcs sensor. User need to set qcsSensor.enabled along with its mandatory parameters according to your need using values.yaml or --set argument of helm.<br>
E.g.<br>

---
    helm install qualys-tc qualys-helm-chart/qualys-tc --namespace qualys --create-namespace --set global.customerId=<customer id>,global.activationId=<activation id>,global.cmsqagPublicUrl=<cmsqagpublicurl>,qcsSensor.enabled=true,clusterSensor.enabled=false
---

### How to install admission controller
Below command will install only admission controller. You can set mandatory paramter either using values.yaml or --set argument of helm.<br>
E.g.<br>

---
    helm install qualys-tc qualys-helm-chart/qualys-tc --set global.customerId=<customer id>,global.activationId==<activationid>,global.gatewayUrl==<gateway Url>,global.clusterInfoArgs.cloudProvider=SELF_MANAGED_K8S,global.clusterInfoArgs.SELF_MANAGED_K8S.clusterName=<cluster name>, admissionController.enabled=true,clusterSensor.enabled=false --namespace qualys --create-namespace
---

Please go through <https://docs.qualys.com/en/cs/latest/#t=admission_controller%2Finstall_adm_ctrl.htm> for detailed instructions 

### How to install runtime-sensor
The below sample command can be used to start the runtime sensor in a node, the values here are set using the --set command<br>
E.g.<br>

---
    helm install qualys-tc qualys-helm-chart/qualys-tc -n qualys --create-namespace --set global.customerId=<customer id>,global.activationId=<activation id>,global.gatewayUrl=<gateway Url>,global.clusterInfoArgs.cloudProvider=SELF_MANAGED_K8S,global.clusterInfoArgs.SELF_MANAGED_K8S.clusterName=<cluster name>,clusterSensor.enabled=false,runtimeSensor.enabled=true
---
NOTE: Please go through <https://docs.qualys.com/en/crs/latest/crs_usage/install_crs.htm> for detailed installation instructions.

#### Instructions for Tracing Policy application in runtime-sensor
To generate a file event, a Tracing Policy needs to be applied. Please go through <https://docs.qualys.com/en/crs/latest/crs_usage/tracing_policies.htm> for detailed instructions.

### How to install multiple applications using this Unified helm chart(qualys-tc)
To enable multiple application such as `cluster sensor`, `admission controller`, `qcs sensor` and `runtime-sensor` in single installation, user need to set admissionController.enabled, qcsSensor.enabled or runtimeSensor.enabled respectively along with its mandatory parameters according to your need. No need to set clusterSensor.enabled as it is true by default<br>
E.g.<br>

---
    helm install qualys-tc qualys-helm-chart/qualys-tc --namespace qualys --create-namespace --set global.customerId=<customer id>,global.activationId=<activation id>,global.gatewayUrl=<gateway Url>,global.cmsqagPublicUrl=<cmsqagpublicurl>,global.clusterInfoArgs.cloudProvider=SELF_MANAGED_K8S,global.clusterInfoArgs.SELF_MANAGED_K8S.clusterName=<cluster name>,admissionController.enabled=true,qcsSensor.enabled=true,runtimeSensor.enabled=true
---

## Upgrading the Release

Use the following command to upgrade the chart:

`helm upgrade [RELEASE] [CHART] [flags]`

Where,

[RELEASE] is the release name.

[CHART] is the chart path.

E.g.

`helm upgrade qualys-tc qualys-helm-chart/qualys-tc --namespace qualys`

If you install any of the applications supported by unified helm chart and would like to additionally install other supported application, it is recommended to perform it with 'helm upgrade' command.

## Uninstalling the Chart

To uninstall use below command.<br>
`helm uninstall qualys-tc -n qualys`  

---
## Contact
Contact <support@qualys.com> for assistance.

