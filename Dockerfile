# base image
FROM ubuntu:26.04 AS base

ENV NODE_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
ENV NPM_CONFIG_LOGLEVEL=warn

RUN apt-get update && apt-get install -y --no-install-recommends \
    binutils \
    build-essential \
    ca-certificates \
    curl \
    file \
    git \
    jq \
    nodejs \
    npm \
    pipx \
    procps \
    python3 \
    python3-pytest \
    unzip \
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

RUN npm install -g @earendil-works/pi-coding-agent@0.85 \
    pi install npm:pi-ask-user \
    pi install npm:pi-mcp-adapter \
    pi install npm:pi-subagents \
    pi install npm:pi-web-access \
    pi install npm:token-rate-pi@latest \
    pi install npm:@agnishc/edb-agent-steer

USER node
ENTRYPOINT ["pi"]
CMD []
