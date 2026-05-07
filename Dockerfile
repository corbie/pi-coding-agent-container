# base image
FROM ubuntu:25.10 AS base

ENV NODE_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
ENV NPM_CONFIG_LOGLEVEL=warn

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    jq \
    nodejs \
    npm \
    pipx \
    procps \
    python3 \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -U node

RUN mkdir -p /home/node/.pi/agent && \
    mkdir -p /workspace && \
    chown -R node:node /home/node/ && \
    chown -R node:node /workspace


# pi image
FROM base AS release

WORKDIR /workspace

RUN npm install -g @mariozechner/pi-coding-agent@0.73.0 \
    pi install npm:token-rate-pi@latest

USER node
ENTRYPOINT ["pi"]
CMD []
