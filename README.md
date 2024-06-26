# Ambient and mTLS

A demo that visually shows how you can go from unencrypted communication to mutual TLS (mTLS) using the Ambient.

Three commands to get started with Istio ambient:

```
brew install istioctl
istioctl install --set profile=ambient -y
kubectl label ns default istio.io/dataplane-mode=ambient
```

## Setup

Create a cluster and deploy the sample apps:

```shell
kind create cluster
kubectl apply -f client.yaml
kubectl apply -f server.yaml
```

## From unencrypted to mTLS

Start sending requests from the client to the server by running the `traffic.sh` script:

```shell
./traffic.sh
```

The script will send random requests from the client pod to the server pod. To watch the traffic on both sides (what's leaving the client and arriving at the server), you can run the `watch.sh` script:

```shell
# Terminal 1: Watch the traffic leaving the client
./watch.sh client

# Terminal 2: Watch the traffic arriving at the server
./watch.sh server
```

Notice the traffic is unencrypted and you can see the contents of the headers and request bodies, including any passwords, API keys or other sensitive information.

Next step is to install Istio ambient:

```shell
brew install istioctl
istioctl install --set profile=ambient -y
```

Finally, enable ambient in the default namespace and observe the traffic again:

```shell
kubectl label namespace default istio.io/dataplane-mode=ambient
```

## L4 metrics

