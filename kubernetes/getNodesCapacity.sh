#!/bin/bash

# VARS
MEM_CAPACITY=0
CPU_CAPACITY=0

# Functions
get_mem() {
    local mem=$(kubectl get nodes -o jsonpath='{.items[*].status.capacity.memory}')
    local mem_array=($mem)
    for i in "${mem_array[@]}"; do
        if [[ $i == *Ki ]]; then
            local mem_value=${i%Ki}
            MEM_CAPACITY=$((MEM_CAPACITY + mem_value))
        elif [[ $i == *Mi ]]; then
            local mem_value=${i%Mi}
            MEM_CAPACITY=$((MEM_CAPACITY + (mem_value * 1024)))
        fi
    done
    echo "Total Memory Capacity: $((MEM_CAPACITY / (1024 * 1024))) Gi"
}

get_cpu() {
    local cpu=$(kubectl get nodes -o jsonpath='{.items[*].status.capacity.cpu}')
    local cpu_array=($cpu)
    for i in "${cpu_array[@]}"; do
        CPU_CAPACITY=$((CPU_CAPACITY + i))
    done
    echo "Total CPU Capacity: $CPU_CAPACITY"
}

# Main
get_mem