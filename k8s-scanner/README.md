# k8s-scanner

<b>k8s-scanner is [RapidFort](https://rapidfort.com)'s Kubernetes SCA scanner</b>

Generate [SBOMs](https://www.rapidfort.com/post/what-is-software-optimization) and get an accurate vulnerability report for every container running in your Kubernetes cluster. View the results on the RapidFort platform.

## Getting Started

1. Create a free account on [RapidFort](https://frontrow.rapidfort.com).

1. Launch the Quick Start guide and click "Kubernetes Scanner" to generate a service account for your Kubernetes instance.

1. Export the RF_ACCESS_ID and RF_SECRET_ACCESS_KEY values for your environment or add them to your profile.

## Installing the Helm Chart

To install the [chart](https://helm.sh/docs/topics/charts/) with the release name `my-release`:

```bash
## Add the RapidFort Helm repository
$ helm repo add rapidfort https://rapidfort.github.io/helm

## Install the k8s-scanner helm chart
$ helm upgrade --install my-release rapidfort/k8s-scanner \
    --set secret.rf_access_id=$RF_ACCESS_ID \
    --set secret.rf_secret_access_key=$RF_SECRET_ACCESS_KEY
```

> **Tip**: List all releases using `helm list --all-namespaces`

## Uninstalling the chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

## Configuration

| Parameter                 | Description  | Default     |
| ---------                 | ------        | ------        |
| `global.rf_root_url`      | RapidFort platform URL | https://frontrow.rapidfort.com |
| `secret.rf_access_id`     | RF_ACCESS_ID for RapidFort service account | "" |
| `secret.rf_secret_access_key`    | RF_SECRET_ACCESS_KEY for RapidFort service account | "" |
| `image.repository`    | Container image repository | "rapidfort/k8s-scanner" |
| `cronSchedule`    | Cron schedule for enumerating images running in Kubernetes cluster | "0 */12 * * *" (Run every 12 hours) |
| `image.tag`   | Container image tag | "latest" |
| `image.pullPolicy`   | Container image pullPolicy | "Always" |
| `imagePullSecrets`   | Image pull secrets for private registry | "[]" |

## Cluster Role

k8s-scanner enumerates a list of all pods running in your Kubernetes cluster, so it requires "list" permission on the "pods" resource for the entire cluster.

```
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["list"]
```

## Host Access

k8s-scanner currently needs to access the host machine's docker socket running at `/var/run` to access Docker images. It also needs access to `/tmp` volume for accessing exported docker images.

```
volumes:
- name: docker-sock
  hostPath:
    path: /var/run
- name: docker-tmp
  hostPath:
    path: /tmp
```
