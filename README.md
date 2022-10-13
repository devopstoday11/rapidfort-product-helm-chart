# helm
RapidFort helm charts repository


## Publish instructions to helm chart

```bash
helm package ./k8s-scanner -d releases
helm repo index --url https://rapidfort.github.io/helm/ .
```
