#!/bin/bash

# VARS
DEPLOYMENTS=0

# Functions
get_deployments() {
    local context=$1
    echo "Using context: $context"
    kubectl config use-context "$context" >/dev/null 2>&1
    local deployments=$(kubectl get deployments --all-namespaces | wc -l)
    DEPLOYMENTS=$((DEPLOYMENTS + deployments))
}

# Main
contexts=$(kubectl config get-contexts -o name)
for context in $contexts; do
    get_deployments "$context"
done

echo "Total Deployments across all contexts: $DEPLOYMENTS"