{{/*
Expand the name of the chart.
*/}}
{{- define "qualys-unified.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "qualys-unified.fullname" -}}
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
{{- define "qualys-unified.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "qualys-unified.labels" -}}
helm.sh/chart: {{ include "qualys-unified.chart" . }}
{{ include "qualys-unified.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "qualys-unified.selectorLabels" -}}
app.kubernetes.io/name: {{ include "qualys-unified.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "qualys-unified.validateValues" -}}
{{- if or .Values.hostBasedSensor.enabled .Values.qualysTc.enabled -}}
  {{- if not .Values.global.customerId -}}
    {{- fail "global.customerId is required when any sensor is enabled" -}}
  {{- end -}}
  {{- if not .Values.global.activationId -}}
    {{- fail "global.activationId is required when any sensor is enabled" -}}
  {{- end -}}
  {{- if not .Values.global.gatewayUrl -}}
    {{- fail "global.gatewayUrl is required when any sensor is enabled" -}}
  {{- end -}}
{{- end -}}

{{- if .Values.hostBasedSensor.enabled -}}
  {{- $providerName := .Values.hostBasedSensor.qualys.args.providerName -}}
  {{- if not $providerName -}}
    {{- fail "hostBasedSensor.qualys.args.providerName is required when hostBasedSensor is enabled. Valid values: AWS, GCP, COREOS" -}}
  {{- end -}}
  {{- if not (has $providerName (list "AWS" "GCP" "COREOS")) -}}
    {{- fail (printf "Invalid hostBasedSensor.qualys.args.providerName: %s. Valid values are: AWS, GCP, COREOS" $providerName) -}}
  {{- end -}}
{{- end -}}

{{- if .Values.qualysTc.enabled -}}
  {{- if and (or .Values.qualysTc.clusterSensor.enabled .Values.qualysTc.runtimeSensor.enabled) (not .Values.global.clusterInfoArgs.cloudProvider) -}}
    {{- fail "global.clusterInfoArgs.cloudProvider is required when cluster sensor or runtime sensor is enabled" -}}
  {{- end -}}
{{- end -}}
{{- end -}}
