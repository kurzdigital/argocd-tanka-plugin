# syntax=docker/dockerfile:1
FROM ubuntu:22.04

ARG JB_VERSION=v0.5.1
ARG TK_VERSION=v0.26.0
ARG HELM_VERSION=v3.11.3

RUN apt-get update && apt-get install git ca-certificates -y --no-install-recommends && rm -rf /var/lib/apt/lists/*
ADD --chmod=755 https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JB_VERSION}/jb-linux-amd64 /usr/local/bin/jb
ADD --chmod=755 https://github.com/grafana/tanka/releases/download/${TK_VERSION}/tk-linux-amd64 /usr/local/bin/tk
ADD https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz /tmp/helm.tar.gz
RUN tar zxvf /tmp/helm.tar.gz --strip-components 1 -C /usr/local/bin/ linux-amd64/helm
COPY plugin.yaml /home/argocd/cmp-server/config/plugin.yaml
COPY scripts/* /

CMD ["/var/run/argocd/argocd-cmp-server"]
