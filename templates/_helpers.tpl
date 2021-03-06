{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Ghost image name
*/}}
{{- define "ghost.image" -}}
{{- $imageRoot := dict -}}
{{- $_ := set $imageRoot "registry" .Values.image.registry -}}
{{- $_ := set $imageRoot "repository" .Values.image.repository -}}
{{- $_ := set $imageRoot "tag" ( .Values.image.tag | default .Chart.AppVersion ) -}}
{{ include "common.images.image" ( dict "imageRoot" $imageRoot "global" .Values.global ) }}
{{- end -}}

{{/*
Return the proper image name to change the volume permissions
*/}}
{{- define "ghost.volumePermissions.image" -}}
{{ include "common.images.image" ( dict "imageRoot" .Values.volumePermissions.image "global" .Values.global ) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "ghost.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" ( dict "images" ( list .Values.image .Values.volumePermissions.image ) "global" .Values.global ) }}
{{- end -}}

{{/*
Get the user defined LoadBalancerIP for this release.
Note, returns 127.0.0.1 if using ClusterIP.
*/}}
{{- define "ghost.serviceIP" -}}
{{- if eq .Values.service.type "ClusterIP" -}}
127.0.0.1
{{- else -}}
{{- .Values.service.loadBalancerIP | default "" -}}
{{- end -}}
{{- end -}}

{{/*
Gets the host to be used for this application.
If not using ClusterIP, or if a host or LoadBalancerIP is not defined, the value will be empty.
*/}}
{{- define "ghost.url" -}}
{{- if .Values.ghostHost -}}
    {{- printf "%s://%s%s" ( ternary "https" "http" .Values.ghostEnableHttps ) .Values.ghostHost .Values.ghostPath | default "" -}}
{{- else -}}
    {{- include "ghost.serviceIP" . -}}
{{- end -}}
{{- end -}}

{{/*
Gets the host to be used to admin this application.
If not using ClusterIP, or if a host or LoadBalancerIP is not defined, the value will be empty.
*/}}
{{- define "ghost.adminUrl" -}}
{{- if .Values.ghostAdminHost -}}
    {{- printf "%s://%s%s" ( ternary "https" "http" .Values.ghostEnableHttps ) .Values.ghostAdminHost .Values.ghostAdminPath | default "" -}}
{{- else -}}
    {{- include "ghost.url" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the MariaDB Hostname
*/}}
{{- define "ghost.databaseHost" -}}
    {{- printf "%s" .Values.externalDatabase.host -}}
{{- end -}}

{{/*
Return the MariaDB Port
*/}}
{{- define "ghost.databasePort" -}}
    {{- printf "%d" ( .Values.externalDatabase.port | int ) -}}
{{- end -}}

{{/*
Return the MariaDB Database Name
*/}}
{{- define "ghost.databaseName" -}}
    {{- printf "%s" .Values.externalDatabase.database -}}
{{- end -}}

{{/*
Return the MariaDB User
*/}}
{{- define "ghost.databaseUser" -}}
    {{- printf "%s" .Values.externalDatabase.user -}}
{{- end -}}

{{/*
Return the MariaDB Secret Name
*/}}
{{- define "ghost.databaseSecretName" -}}
{{- if .Values.externalDatabase.existingSecret -}}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else if .Values.externalDatabase.password -}}
    {{- printf "%s-externaldb" ( include "common.names.fullname" . ) -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Return the SMTP Secret Name
*/}}
{{- define "ghost.smtpSecretName" -}}
{{- if .Values.smtpExistingSecret -}}
    {{- printf "%s" .Values.smtpExistingSecret -}}
{{- else if .Values.smtpPassword -}}
    {{- printf "%s-smtp" ( include "common.names.fullname" . ) -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "ghost.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages ( include "ghost.validateValues.database" . ) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}
{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/* Validate values of Ghost - Database */}}
{{- define "ghost.validateValues.database" -}}
{{- if or ( empty .Values.externalDatabase.host ) ( empty .Values.externalDatabase.port ) ( empty .Values.externalDatabase.database ) -}}
ghost: database
   You did not provide the required parameters to use an external database. 
   To use an external database, please ensure you provide
   (at least) the following values:

       externalDatabase.host=DB_SERVER_HOST
       externalDatabase.database=DB_NAME
       externalDatabase.port=DB_SERVER_PORT
{{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "ghost.ingress.certManagerRequest" -}}
{{ if or ( hasKey . "cert-manager.io/cluster-issuer" ) ( hasKey . "cert-manager.io/issuer" ) }}
    {{- true -}}
{{- end -}}
{{- end -}}
