{{/*
Expand the name of the chart.
*/}}
{{- define "qcs-sensor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "qcs-sensor.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "qcs-sensor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "qcs-sensor.labels" -}}
helm.sh/chart: {{ include "qcs-sensor.chart" . }}
{{ include "qcs-sensor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "qcs-sensor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "qcs-sensor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "qcs-sensor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "qcs-sensor.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Add Warning message for deprecating arguments
*/}}
{{- define "warning.message" -}}
{{- if and .Values.containerd.enabled .Values.qualys.args.enableStorageDriver }}
WARNING: 'enableStorageDriver' flag will be deprecated in future releases.
{{- end }}
{{- if .Values.qualys.tolerations.enabled }}
WARNING: 'qualys.tolerations' will be deprecated in future releases. Use 'tolerations' instead.
{{- end }}
{{- if .Values.qualys.cpu }}
WARNING: 'qualys.cpu' will be deprecated in future releases. Use 'qualys.sensorContResources.limits.cpu' instead.
{{- end }}
{{- end }}