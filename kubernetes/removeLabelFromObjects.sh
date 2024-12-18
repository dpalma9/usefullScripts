#!/bin/bash

animate_progress() { local action=$1 chars="/-\|"; [[ "$action" == "start" ]] && { while :; do for ((i=0; i<${#chars}; i++)); do echo -ne "\rUpdating label in progress... ${chars:$i:1}"; sleep 0.2; done; done & ANIMATION_PID=$!; } || { kill "$ANIMATION_PID" 2>/dev/null; echo -ne "\rUpdating label in progress... Done!                    \n"; }; }
animate_progress start
trap 'animate_progress stop' EXIT

objects=(
  "ConfigMap"
  "Endpoints"
  "LimitRange"
  "PersistentVolumeClaim"
  "Pod"
  "PodTemplate"
  "ReplicationController"
  "Deployment"
  "Daemonset"
  "Statefulset"
  "ResourceQuota"
  "ServiceAccount"
  "Service"
  "Secret"
  "Role.rbac.authorization.k8s.io"
  "RoleBinding.rbac.authorization.k8s.io"
  "PodDisruptionBudget.policy"
  "MutatingWebhookConfiguration.admissionregistration.k8s.io"
  "ValidatingWebhookConfiguration.admissionregistration.k8s.io"
  "Task.tekton.dev"
  "ClusterTask.tekton.dev"
  "TaskRun.tekton.dev"
  "Pipeline.tekton.dev"
  "PipelineRun.tekton.dev"
  "CustomRun.tekton.dev"
  "HorizontalPodAutoscaler.autoscaling"
  "Gateway.networking.istio.io"
  "VirtualService.networking.istio.io"
  "DestinationRules.networking.istio.io"
  "ServiceEntries.networking.istio.io"
  "EnvoyFilter.networking.istio.io"
  "Sidecar.networking.istio.io"
  "AuthorizationPolicy.security.istio.io"
  "PeerAuthentication.security.istio.io"
  "NetworkAttachmentDefinition.k8s.cni.cncf.io"
  "VaultConnection.secrets.hashicorp.com"
  "VaultStaticSecret.secrets.hashicorp.com"
  "VaultAuth.secrets.hashicorp.com"
  "Namespace"
  "PersistentVolume"
  "ClusterRole.rbac.authorization.k8s.io"
  "ClusterRoleBinding.rbac.authorization.k8s.io"
  "CustomResourceDefinition.apiextensions.k8s.io"
  "ConstraintTemplate.templates.gatekeeper.sh"
  "Telemetry.telemetry.istio.io"
  "SecurityContextConstraints.security.openshift.io"
  "PriorityClass.scheduling.k8s.io"
  "MachineConfigPool.machineconfiguration.openshift.io"
  "MachineConfig.machineconfiguration.openshift.io"
  "KubeletConfig.machineconfiguration.openshift.io"
  "OAuth.config.openshift.io"
  "Proxy.config.openshift.io"
)


LABEL_FILTER="label.that.must.exist.to.filter"
LABEL_REMOVE="app.kubernetes.io/instance" # label you want to remove
LOG_FILE="script_log_$(date "+%Y-%m-%d_%H-%M-%S").txt"

log_message() {
  echo "$1" >> "$LOG_FILE"
}

process_labels() {
  local kind="$1"
  local namespace="$2"
  local name="$3"
  local label_value="$4"
  local labels

  log_message "Found object $kind/$name with label '$LABEL_FILTER' and $LABEL_REMOVE ${namespace:+in namespace $namespace}"
  kubectl label "$kind" ${namespace:+-n "$namespace"} "$name" "$LABEL_REMOVE"- &>> "$LOG_FILE"
  if [[ $? -eq 0 ]]; then
    log_message "Removed label '$LABEL_REMOVE' with value $label_value from $kind/$name ${namespace:+in namespace $namespace}"
  else
    log_message "Failed to remove label '$LABEL_REMOVE' from $kind/$name ${namespace:+in namespace $namespace}"
  fi
 
}

contexts=$(kubectl config get-contexts -o name) #you can run the script throw all the clusters on your kubeconfig
for context in $contexts; do
  kubectl config use-context "$context" &>> "$LOG_FILE"
  if [[ $? -ne 0 ]]; then
    log_message "Failed to switch to context $context"
    continue
  fi
  # Process namespaced resources
  for kind in "${objects[@]}"; do
    resources=$(kubectl get "$kind" -l "$LABEL_FILTER,$LABEL_REMOVE" --all-namespaces -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,LABEL_DELETE_VALUE:.metadata.labels.${LABEL_REMOVE//./\\.}" --ignore-not-found 2>>"$LOG_FILE")
    if [[ $? -ne 0 ]]; then
      log_message "Failed to get filtered $kind objects across all namespaces in context $context"
      continue
    fi
    # Complex scenario where the label you want to filter must have a specific value
    #echo "$resources" | tail -n +2 | while read -r namespace name label_delete_value; do
    #  if [[ "$label_delete_value" == "$context.cxb-"* ]]; then
    #    if [[ -n "$namespace" && -n "$name" ]]; then
    #      if [[ "$namespace" == "<none>" ]]; then
    #        process_labels "$kind" "" "$name" "$label_delete_value"
    #      else
    #        process_labels "$kind" "$namespace" "$name" "$label_delete_value"
    #      fi
    #    fi
    #  fi

    # The simple scenario:
    echo "$resources" | tail -n +2 | while read -r namespace name; do
      if [[ -n "$namespace" && -n "$name" ]]; then
        if [[ "$namespace" == "<none>" ]]; then
          process_labels "$kind" "" "$name"
        else
          process_labels "$kind" "$namespace" "$name"
        fi
      fi
    done
  done
done