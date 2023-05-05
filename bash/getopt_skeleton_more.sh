#!/bin/bash

## VARS BLOCK
# General vars
ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP=false
MODIFY=false
APPLY=false

# K8S vars
ORIG_KUBE_CONFIG="/root/.kube/config"
DEST_KUBE_CONFIG=""
NAMESPACES=()

## LOAD EXTERNAL METHODS
source "$ROOT_DIR/utils/messages.sh"

## MAIN
# Call getopt to validate the provided input. 
options=$(getopt \
            -o "a,A,h,H" \
            --long "help,all,apply,backup,modify" \
            --long "orig-kubeconfig:,dest-kubeconfig:,namespaces:" -- "$@")


if [ $# -eq 0 ]; then
    info "No parameters provided!"
    error "Use the help to check the usage."
fi

eval set -- "$options"

while [ $# -ge 1 ]; do
    case "$1" in
    -a|-A|--all)
        BACKUP=true;
        MODIFY=true;
        APPLY=true;
        shift;;
    --apply)
        APPLY=true;
        shift;;
    --backup)
        BACKUP=true;
        shift;;
    --modify)
        MODIFY=true;
        shift;;
    --dest-kubeconfig)
        shift;
        DEST_KUBE_CONFIG=$1;
        shift;;
    --namespaces)
        shift;
        NAMESPACES=$1;
        shift;;
    --orig-kubeconfig)
        shift;
        ORIG_KUBE_CONFIG=$1;
        shift;;
    -h|-H|--help)
        help;
        exit 1;;
    --) #This option allows that, once all flags were read, break the loop.
        shift;
        break;;
    -*) #TODO not working
        error "$1 is invalid option!";;
    esac
done

# Create scenario after read options
echo "Vamos a probar las opciones"
echo "Modify: $MODIFY"
echo "Apply: $APPLY"
echo "Backup: $BACKUP"
echo "Dest kubeconfig: $DEST_KUBE_CONFIG"
echo "Orig kubeconfig: $ORIG_KUBE_CONFIG"
echo "namespaces: $NAMESPACES"
echo "Fin"