{{- define "registryscan.registry.config" -}}
{{- $config := (include "get.root" .) | fromYaml }}
{{- $_ := set $config "featureName" "registryscan" }}
{{- $_ := set $config "agentName" "registry" }}
{{- $_ := set $config "featureConfig" $config.Values.addons.registryScan }}
{{- $_ := set $config "agentConfig" $config.Values.addons.registryScan.registry }}
{{- $_ := set $config "containerRuntime" (include "get.container.runtime" .) }}
{{- $config | toYaml -}}
{{- end -}}

{{- define "registryscan.engine.resource.name" -}}
{{- $engineConfig := fromYaml (include "registryscan.engine.config" .) -}}
{{ template "agent.resource.name" $engineConfig }}
{{- end -}}