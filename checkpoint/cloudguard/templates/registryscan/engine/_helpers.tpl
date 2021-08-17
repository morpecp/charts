{{- define "registryscan.engine.config" -}}
{{- $config := (include "get.root" .) | fromYaml }}
{{- $_ := set $config "featureName" "registryscan" }}
{{- $_ := set $config "agentName" "engine" }}
{{- $_ := set $config "featureConfig" $config.Values.addons.registryScan }}
{{- $_ := set $config "agentConfig" $config.Values.addons.registryScan.engine }}
{{- $_ := set $config "containerRuntime" (include "get.container.runtime" .) }}
{{- $config | toYaml -}}
{{- end -}}

{{- define "registryscan.registry.resource.name" -}}
{{- $registryConfig := fromYaml (include "registryscan.registry.config" .) -}}
{{ template "agent.resource.name" $registryConfig }}
{{- end -}}

{{- define "registryscan.engine.resources" -}}
{{- if .agentConfig.resources }}
resources:
  requests:
    cpu: {{ .agentConfig.resources.requests.cpu }}
    memory: {{ .agentConfig.resources.requests.memory }}
  limits:
    cpu: {{ .agentConfig.resources.limits.cpu }}
{{- if .featureConfig.maxImageSizeMb }}
{{- /* the memory consumption of imagescan engine is the largest image size it is configured to scan + 500Mi */}}
    memory: {{ add 500 .featureConfig.maxImageSizeMb }}Mi
{{- else }}
    memory: {{ .agentConfig.resources.limits.memory }}
{{- end }}
{{- end -}}
{{- end }}