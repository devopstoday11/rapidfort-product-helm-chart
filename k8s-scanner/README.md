# k8s-scanner

<b> k8s-scanner scans all images in k8s cluster with RapidFort rf-scan tool </b>

## Usage

#### Installing k8s-scanner, ensure you have RF_ACCESS_ID and RF_SECRET_ACCESS_KEY in env
```bash
helm repo add rapidfort https://rapidfort.github.io/helm

helm upgrade --install rel1 rapidfort/k8s-scanner \
    --set secret.rf_access_id=$RF_ACCESS_ID \
    --set secret.rf_secret_access_key=$RF_SECRET_ACCESS_KEY \
```

#### Uninstalling k8s-scanner

```bash
helm delete rel1
```
