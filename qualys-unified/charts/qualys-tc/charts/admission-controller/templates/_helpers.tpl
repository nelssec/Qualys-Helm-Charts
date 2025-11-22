{{/*
Expand the name of the chart.
*/}}
{{- define "admission-controller.name" -}}
{{- default .Chart.Name "admission-controller" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "admission-controller.fullname" -}}
{{- default .Chart.Name "admission-controller" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/**/}}
{{/*Create a default fully qualified app name.*/}}
{{/*We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).*/}}
{{/*If release name contains chart name it will be used as a full name.*/}}
{{/**/}}
{{/*{{- define "admission-controller.fullname" -}}*/}}
{{/*{{- if .Values.fullnameOverride }}*/}}
{{/*{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}*/}}
{{/*{{- else }}*/}}
{{/*{{- $name := default .Chart.Name .Values.nameOverride }}*/}}
{{/*{{- if contains $name .Release.Name }}*/}}
{{/*{{- .Release.Name | trunc 63 | trimSuffix "-" }}*/}}
{{/*{{- else }}*/}}
{{/*{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}*/}}
{{/*{{- end }}*/}}
{{/*{{- end }}*/}}
{{/*{{- end }}*/}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "admission-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "admission-controller.labels" -}}
helm.sh/chart: {{ include "admission-controller.chart" . }}
{{ include "admission-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "admission-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "admission-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the prometheus account to use
*/}}
{{- define "admission-controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "admission-controller.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
cert-manager config
*/}}
{{- define "admission-controller.certManagerInject" -}}
{{- if eq .Values.certs.certsProvider "cert-manager" -}}
{{- printf "%s/%s-certs" .Release.Namespace (include "admission-controller.fullname" .) -}}
{{- else -}}
{{- default ""}}
{{- end -}}
{{- end -}}

{{/*
rolling update hashes
*/}}
{{- define "helpers.calculateHash" -}}
{{- $list := . -}}
{{- $hash := printf "%s" $list | sha256sum -}}
{{- $hashTrimmed := $hash | trimSuffix "\n" -}}
{{- $hashTrimmed -}}
{{- end -}}

{{- define "admission-controller.apiConfigHash" -}}
{{ include "helpers.calculateHash" (list .Values.global.customerId .Values.global.activationId .Values.global.gatewayUrl) }}
{{- end }}

{{- define "admission-controller.proxyHash" -}}
{{ include "helpers.calculateHash" (list .Values.global.proxy.value .Values.global.proxy.certificate .Values.global.proxy.skipVerifyTLS) }}
{{- end }}