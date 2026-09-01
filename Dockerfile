# base image
FROM ubuntu:26.04 AS base

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
    python3-pytest \
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

RUN npm install -g @earendil-works/pi-coding-agent@0.84.3 \
    pi install npm:token-rate-pi@latest \
    pi install npm:pi-web-access \
    pi install npm:pi-mcp-adapter \
    pi install npm:pi-subagents \
    pi install npm:@agnishc/edb-agent-steer

USER node
ENTRYPOINT ["pi"]
CMD []
