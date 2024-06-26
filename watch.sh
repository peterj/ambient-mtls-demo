#!/bin/bash

# Given the app label value, the script runs the kubectl debug command
# against one of the pods from that deployment

# Usage: ./watch.sh <app_label>

if [ -z "$1" ]; then
    echo "Usage: ./watch.sh <app_label>"
    exit 1
fi

POD=$(kubectl get pods -l app=$1 -o jsonpath="{.items[0].metadata.name}")

echo "Watching $POD"
kubectl debug $POD -i --image=nicolaka/netshoot -- ngrep -d eth0 