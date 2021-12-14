# Ghost

[Ghost](https://ghost.org/) is an open source publishing platform designed to create blogs, magazines, and news sites. It includes a simple markdown editor with preview, theming, and SEO built-in to simplify editing.

## TL;DR

```console
$ git clone https://github.com/mainnika/ghost-helm
$ helm install my-release ./ghost-helm
```

## Introduction

This chart bootstraps a [Ghost](https://github.com/mainnika/ghost-docker) deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

There is neither embedded mysql database or sqlite support, the only external database is supported.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling
- External database (like MariaDB)

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ git clone https://github.com/mainnika/ghost-helm
$ helm install my-release ./ghost-helm
```

The command deploys Ghost on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |


### Common parameters

| Name                | Description                                        | Value           |
| ------------------- | -------------------------------------------------- | --------------- |
| `kubeVersion`       | Override Kubernetes version                        | `""`            |
| `nameOverride`      | String to partially override common.names.fullname | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname     | `""`            |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`            |
| `clusterDomain`     | Kubernetes cluster domain name                     | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release  | `[]`            |


### Ghost Image parameters

| Name                | Description                                      | Value                 |
| ------------------- | ------------------------------------------------ | --------------------- |
| `image.registry`    | Ghost image registry                             | `ghcr.io`             |
| `image.repository`  | Ghost image repository                           | `mainnika/ghost`      |
| `image.tag`         | Ghost image tag (immutable tags are recommended) | ``                    |
| `image.pullPolicy`  | Ghost image pull policy                          | `IfNotPresent`        |
| `image.pullSecrets` | Ghost image pull secrets                         | `[]`                  |
| `image.debug`       | Enable image debug mode                          | `false`               |


### Ghost Configuration parameters

| Name                 | Description                                                          | Value              |
| -------------------- | -------------------------------------------------------------------- | ------------------ |
| `ghostEmail`         | Ghost user email                                                     | `user@example.com` |
| `ghostHost`          | Ghost host to create application URLs                                | `""`               |
| `ghostPath`          | URL sub path where to server the Ghost application                   | `/`                |
| `ghostEnableHttps`   | Configure Ghost to build application URLs using https                | `false`            |
| `smtpHost`           | SMTP server host                                                     | `""`               |
| `smtpPort`           | SMTP server port                                                     | `""`               |
| `smtpUser`           | SMTP username                                                        | `""`               |
| `smtpPassword`       | SMTP user password                                                   | `""`               |
| `smtpService`        | SMTP service                                                         | `""`               |
| `smtpExistingSecret` | The name of an existing secret with SMTP credentials                 | `""`               |
| `command`            | Override default container command (useful when using custom images) | `[]`               |
| `args`               | Override default container args (useful when using custom images)    | `[]`               |
| `extraEnvVars`       | Array with extra environment variables to add to the Ghost container | `[]`               |
| `extraEnvVarsCM`     | Name of existing ConfigMap containing extra env vars                 | `""`               |
| `extraEnvVarsSecret` | Name of existing Secret containing extra env vars                    | `""`               |


### Ghost deployment parameters

| Name                                    | Description                                                                               | Value           |
| --------------------------------------- | ----------------------------------------------------------------------------------------- | --------------- |
| `replicaCount`                          | Number of Ghost replicas to deploy                                                        | `1`             |
| `updateStrategy.type`                   | Ghost deployment strategy type                                                            | `RollingUpdate` |
| `priorityClassName`                     | Ghost pod priority class name                                                             | `""`            |
| `schedulerName`                         | Name of the k8s scheduler (other than default)                                            | `""`            |
| `topologySpreadConstraints`             | Topology Spread Constraints for pod assignment                                            | `[]`            |
| `hostAliases`                           | Ghost pod host aliases                                                                    | `[]`            |
| `extraVolumes`                          | Optionally specify extra list of additional volumes for Ghost pods                        | `[]`            |
| `extraVolumeMounts`                     | Optionally specify extra list of additional volumeMounts for Ghost container(s)           | `[]`            |
| `sidecars`                              | Add additional sidecar containers to the Ghost pod                                        | `[]`            |
| `initContainers`                        | Add additional init containers to the Ghost pods                                          | `[]`            |
| `lifecycleHooks`                        | Add lifecycle hooks to the Ghost deployment                                               | `{}`            |
| `podLabels`                             | Extra labels for Ghost pods                                                               | `{}`            |
| `podAnnotations`                        | Annotations for Ghost pods                                                                | `{}`            |
| `podAffinityPreset`                     | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`            |
| `podAntiAffinityPreset`                 | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`          |
| `nodeAffinityPreset.type`               | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`            |
| `nodeAffinityPreset.key`                | Node label key to match. Ignored if `affinity` is set                                     | `""`            |
| `nodeAffinityPreset.values`             | Node label values to match. Ignored if `affinity` is set                                  | `[]`            |
| `affinity`                              | Affinity for pod assignment                                                               | `{}`            |
| `nodeSelector`                          | Node labels for pod assignment                                                            | `{}`            |
| `tolerations`                           | Tolerations for pod assignment                                                            | `{}`            |
| `resources.limits`                      | The resources limits for the Ghost container                                              | `{}`            |
| `resources.requests`                    | The requested resources for the Ghost container                                           | `{}`            |
| `containerPorts.http`                   | Ghost HTTP container port                                                                 | `2368`          |
| `containerPorts.https`                  | Ghost HTTPS container port                                                                | `2368`          |
| `podSecurityContext.enabled`            | Enabled Ghost pods' Security Context                                                      | `true`          |
| `podSecurityContext.fsGroup`            | Set Ghost pod's Security Context fsGroup                                                  | `1000`          |
| `containerSecurityContext.enabled`      | Enabled Ghost containers' Security Context                                                | `true`          |
| `containerSecurityContext.runAsUser`    | Set Ghost container's Security Context runAsUser                                          | `1000`          |
| `containerSecurityContext.runAsNonRoot` | Set Ghost container's Security Context runAsNonRoot                                       | `true`          |
| `startupProbe.enabled`                  | Enable startupProbe                                                                       | `false`         |
| `startupProbe.initialDelaySeconds`      | Initial delay seconds for startupProbe                                                    | `120`           |
| `startupProbe.periodSeconds`            | Period seconds for startupProbe                                                           | `10`            |
| `startupProbe.timeoutSeconds`           | Timeout seconds for startupProbe                                                          | `5`             |
| `startupProbe.failureThreshold`         | Failure threshold for startupProbe                                                        | `6`             |
| `startupProbe.successThreshold`         | Success threshold for startupProbe                                                        | `1`             |
| `livenessProbe.enabled`                 | Enable livenessProbe                                                                      | `true`          |
| `livenessProbe.initialDelaySeconds`     | Initial delay seconds for livenessProbe                                                   | `120`           |
| `livenessProbe.periodSeconds`           | Period seconds for livenessProbe                                                          | `10`            |
| `livenessProbe.timeoutSeconds`          | Timeout seconds for livenessProbe                                                         | `5`             |
| `livenessProbe.failureThreshold`        | Failure threshold for livenessProbe                                                       | `6`             |
| `livenessProbe.successThreshold`        | Success threshold for livenessProbe                                                       | `1`             |
| `readinessProbe.enabled`                | Enable readinessProbe                                                                     | `true`          |
| `readinessProbe.initialDelaySeconds`    | Initial delay seconds for readinessProbe                                                  | `30`            |
| `readinessProbe.periodSeconds`          | Period seconds for readinessProbe                                                         | `5`             |
| `readinessProbe.timeoutSeconds`         | Timeout seconds for readinessProbe                                                        | `3`             |
| `readinessProbe.failureThreshold`       | Failure threshold for readinessProbe                                                      | `6`             |
| `readinessProbe.successThreshold`       | Success threshold for readinessProbe                                                      | `1`             |
| `customLivenessProbe`                   | Custom livenessProbe that overrides the default one                                       | `{}`            |
| `customReadinessProbe`                  | Custom readinessProbe that overrides the default one                                      | `{}`            |


### Traffic Exposure Parameters

| Name                               | Description                                                                                                                      | Value                    |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                     | Ghost service type                                                                                                               | `LoadBalancer`           |
| `service.ports.http`               | Ghost service HTTP port                                                                                                          | `80`                     |
| `service.ports.https`              | Ghost service HTTPS port                                                                                                         | `443`                    |
| `service.nodePorts.http`           | Node port for HTTP                                                                                                               | `""`                     |
| `service.nodePorts.https`          | Node port for HTTPS                                                                                                              | `""`                     |
| `service.clusterIP`                | Ghost service Cluster IP                                                                                                         | `""`                     |
| `service.loadBalancerIP`           | Ghost service Load Balancer IP                                                                                                   | `""`                     |
| `service.loadBalancerSourceRanges` | Ghost service Load Balancer sources                                                                                              | `[]`                     |
| `service.externalTrafficPolicy`    | Ghost service external traffic policy                                                                                            | `Cluster`                |
| `service.annotations`              | Additional custom annotations for Ghost service                                                                                  | `{}`                     |
| `service.extraPorts`               | Extra port to expose on Ghost service                                                                                            | `[]`                     |
| `service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                                             | `None`                   |
| `service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                                      | `{}`                     |
| `ingress.enabled`                  | Enable ingress record generation for Ghost                                                                                       | `false`                  |
| `ingress.pathType`                 | Ingress path type                                                                                                                | `ImplementationSpecific` |
| `ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                                                    | `""`                     |
| `ingress.hostname`                 | Default host for the ingress record                                                                                              | `ghost.local`            |
| `ingress.path`                     | Default path for the ingress record                                                                                              | `/`                      |
| `ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `ingress.tls`                      | Enable TLS configuration for the host defined at `ingress.hostname` parameter                                                    | `false`                  |
| `ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`                  |
| `ingress.extraHosts`               | An array with additional hostname(s) to be covered with the ingress record                                                       | `[]`                     |
| `ingress.extraPaths`               | An array with additional arbitrary paths that may need to be added to the ingress under the main host                            | `[]`                     |
| `ingress.extraTls`                 | TLS configuration for additional hostname(s) to be covered with this ingress record                                              | `[]`                     |
| `ingress.secrets`                  | Custom TLS certificates as secrets                                                                                               | `[]`                     |
| `ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                     |


### Persistence Parameters

| Name                                          | Description                                                                                     | Value                   |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------- |
| `persistence.enabled`                         | Enable persistence using Persistent Volume Claims                                               | `true`                  |
| `persistence.storageClass`                    | Persistent Volume storage class                                                                 | `""`                    |
| `persistence.annotations`                     | Additional custom annotations for the PVC                                                       | `{}`                    |
| `persistence.accessModes`                     | Persistent Volume access modes                                                                  | `[]`                    |
| `persistence.size`                            | Persistent Volume size                                                                          | `8Gi`                   |
| `persistence.existingClaim`                   | The name of an existing PVC to use for persistence                                              | `""`                    |
| `volumePermissions.enabled`                   | Enable init container that changes the owner/group of the PV mount point to `runAsUser:fsGroup` | `false`                 |
| `volumePermissions.image.registry`            | Bitnami Shell image registry                                                                    | `docker.io`             |
| `volumePermissions.image.repository`          | Bitnami Shell image repository                                                                  | `bitnami/bitnami-shell` |
| `volumePermissions.image.tag`                 | Bitnami Shell image tag (immutable tags are recommended)                                        | `10-debian-10-r265`     |
| `volumePermissions.image.pullPolicy`          | Bitnami Shell image pull policy                                                                 | `IfNotPresent`          |
| `volumePermissions.image.pullSecrets`         | Bitnami Shell image pull secrets                                                                | `[]`                    |
| `volumePermissions.resources.limits`          | The resources limits for the init container                                                     | `{}`                    |
| `volumePermissions.resources.requests`        | The requested resources for the init container                                                  | `{}`                    |
| `volumePermissions.securityContext.runAsUser` | Set init container's Security Context runAsUser                                                 | `0`                     |


### Database Parameters

| Name                                       | Description                                                               | Value           |
| ------------------------------------------ | ------------------------------------------------------------------------- | --------------- |
| `externalDatabase.host`                    | External Database server host                                             | `localhost`     |
| `externalDatabase.port`                    | External Database server port                                             | `3306`          |
| `externalDatabase.user`                    | External Database username                                                | `ghost`      |
| `externalDatabase.password`                | External Database user password                                           | `""`            |
| `externalDatabase.database`                | External Database database name                                           | `ghost` |
| `externalDatabase.existingSecret`          | The name of an existing secret with database credentials                  | `""`            |


### NetworkPolicy parameters

| Name                                                          | Description                                                                                                               | Value   |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------- |
| `networkPolicy.enabled`                                       | Enable network policies                                                                                                   | `false` |
| `networkPolicy.ingress.enabled`                               | Enable network policy for Ingress Proxies                                                                                 | `false` |
| `networkPolicy.ingress.namespaceSelector`                     | Ingress Proxy namespace selector labels. These labels will be used to identify the Ingress Proxy's namespace.             | `{}`    |
| `networkPolicy.ingress.podSelector`                           | Ingress Proxy pods selector labels. These labels will be used to identify the Ingress Proxy pods.                         | `{}`    |
| `networkPolicy.ingressRules.accessOnlyFrom.enabled`           | Enable ingress rule that makes Ghost only accessible from a particular origin                                             | `false` |
| `networkPolicy.ingressRules.accessOnlyFrom.namespaceSelector` | Namespace selector label that is allowed to access Ghost. This label will be used to identified the allowed namespace(s). | `{}`    |
| `networkPolicy.ingressRules.accessOnlyFrom.podSelector`       | Pods selector label that is allowed to access Ghost. This label will be used to identified the allowed pod(s).            | `{}`    |
| `networkPolicy.ingressRules.customRules`                      | Custom network policy ingress rule                                                                                        | `{}`    |


> **Note**:
>
> For the Ghost application function correctly, you should specify the `ghostHost` parameter to specify the FQDN (recommended) or the public IP address of the Ghost service.
>
> Optionally, you can specify the `ghostLoadBalancerIP` parameter to assign a reserved IP address to the Ghost service of the chart. However please note that this feature is only available on a few cloud providers (f.e. GKE).
>
> To reserve a public IP address on GKE:
>
> ```bash
> $ gcloud compute addresses create ghost-public-ip
> ```
>
> The reserved IP address can be assigned to the Ghost service by specifying it as the value of the `service.loadBalancerIP` parameter while installing the chart.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set externalDatabase.password=secretpassword ./ghost-helm
```

The above command sets the Ghost administrator account username and password to `admin` and `password` respectively. Additionally, it sets the MariaDB `root` user password to `secretpassword`.

> NOTE: Once this chart is deployed, it is not possible to change the application's access credentials, such as usernames or passwords, using Helm. To change these application credentials after deployment, delete any persistent volumes (PVs) used by the chart and re-deploy it, or use the application's built-in administrative tools if available.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml bitnami/ghost
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

### External database support

The chart allows you to specify credentials for an external database with the [`externalDatabase` parameter](#database-parameters). Here is an example:

```console
externalDatabase.host=myexternalhost
externalDatabase.user=myuser
externalDatabase.password=mypassword
externalDatabase.database=mydatabase
externalDatabase.port=3306
```

Refer to the [documentation on using an external database with Ghost](https://docs.bitnami.com/kubernetes/apps/ghost/configuration/use-external-database/) for more information.

### Configure Ingress

This chart provides support for Ingress resources. If you have an ingress controller installed on your cluster, such as [nginx-ingress-controller](https://github.com/bitnami/charts/tree/master/bitnami/nginx-ingress-controller) or [contour](https://github.com/bitnami/charts/tree/master/bitnami/contour) you can utilize the ingress controller to serve your application.

To enable Ingress integration, set `ingress.enabled` to `true`. The `ingress.hostname` property can be used to set the host name. The `ingress.tls` parameter can be used to add the TLS configuration for this host. It is also possible to have more than one host, with a separate TLS configuration for each host. [Learn more about configuring and using Ingress](https://docs.bitnami.com/kubernetes/apps/ghost/configuration/configure-ingress/).

### Configure TLS Secrets for use with Ingress

The chart also facilitates the creation of TLS secrets for use with the Ingress controller, with different options for certificate management. [Learn more about TLS secrets](https://docs.bitnami.com/kubernetes/apps/ghost/administration/enable-tls-ingress/).

### Configure extra environment variables

To add extra environment variables (useful for advanced operations like custom init scripts), use the `extraEnvVars` property.

```yaml
extraEnvVars:
  - name: LOG_LEVEL
    value: DEBUG
```

Alternatively, use a ConfigMap or a Secret with the environment variables. To do so, use the `extraEnvVarsCM` or the `extraEnvVarsSecret` values.

### Configure Sidecars and Init Containers

If additional containers are needed in the same pod as Ghost (such as additional metrics or logging exporters), they can be defined using the `sidecars` parameter. Similarly, you can add extra init containers using the `initContainers` parameter.

[Learn more about configuring and using sidecar and init containers](https://docs.bitnami.com/kubernetes/apps/ghost/configuration/configure-sidecar-init-containers/).

### Deploy extra resources

There are cases where you may want to deploy extra objects, such a ConfigMap containing your app's configuration or some extra deployment with a micro service used by your app. For covering this case, the chart allows adding the full specification of other objects using the `extraDeploy` parameter.

### Set Pod affinity

This chart allows you to set custom Pod affinity using the `affinity` parameter(s). Find more information about Pod affinity in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, you can use the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [bitnami/common](https://github.com/bitnami/charts/tree/master/bitnami/common#affinities) chart. To do so, set the `podAffinityPreset`, `podAntiAffinityPreset`, or `nodeAffinityPreset` parameters.

## Persistence

The [Ghost](https://github.com/mainnika/ghost-docker) image stores the Ghost data and configurations at the `/var/lib/ghost/content` paths of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Parameters](#parameters) section to configure the PVC or to disable persistence.
