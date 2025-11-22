{{/*
Add Warning message for deprecating arguments
*/}}
{{- define "warning.message" -}}
{{- if and (.Values.qcsSensor).enabled (.Values.qcsSensor).containerd.enabled (.Values.qcsSensor).qualys.args.enableStorageDriver }}
WARNING: 'enableStorageDriver' flag will be deprecated in future releases.
{{- end }}
{{- if and (.Values.qcsSensor).enabled (.Values.qcsSensor).qualys.tolerations.enabled }}
WARNING: 'qcsSensor.qualys.tolerations' flag will be deprecated in future releases. Use 'qcsSensor.tolerations' instead.
{{- end }}
{{- end }}
