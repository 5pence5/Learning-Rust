FROM mcr.microsoft.com/devcontainers/rust:1-1-bullseye

# Install basic tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    git \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create directory for neovim
RUN mkdir -p ~/.local

# Set up workspace
WORKDIR /workspace
