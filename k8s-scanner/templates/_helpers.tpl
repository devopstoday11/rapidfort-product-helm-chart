{{/*
Expand the name of the chart.
*/}}
{{- define "k8s-scanner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" | replace "_" "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "k8s-scanner.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | replace "_" "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-"  | replace "_" "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-"  | replace "_" "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "k8s-scanner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "k8s-scanner.labels" -}}
helm.sh/chart: {{ include "k8s-scanner.chart" . }}
{{ include "k8s-scanner.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "k8s-scanner.selectorLabels" -}}
app.kubernetes.io/name: {{ include "k8s-scanner.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "k8s-scanner.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "k8s-scanner.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the cluster role to use
*/}}
{{- define "k8s-scanner.clusterRoleName" -}}
{{- if .Values.clusterRole.create }}
{{- default (include "k8s-scanner.fullname" .) .Values.clusterRole.name }}
{{- else }}
{{- default "default" .Values.clusterRole.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the cluster role binding to use
*/}}
{{- define "k8s-scanner.clusterRoleBindingName" -}}
{{- if .Values.clusterRoleBinding.create }}
{{- default (include "k8s-scanner.fullname" .) .Values.clusterRoleBinding.name }}
{{- else }}
{{- default "default" .Values.clusterRoleBinding.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the configmap to use
*/}}
{{- define "k8s-scanner.configMapName" -}}
{{- default (include "k8s-scanner.fullname" .) .Values.configMap.name }}
{{- end }}


{{/*
Create the name of the secrets to use
*/}}
{{- define "k8s-scanner.secretName" -}}
{{- default (include "k8s-scanner.fullname" .) .Values.secret.name }}
{{- end }}

{{/*
Create random string for help message
*/}}
{{- define "k8s-scanner.trial_job_run" -}}
{{- randAlphaNum 6 | lower | nospace -}}
{{- end -}}