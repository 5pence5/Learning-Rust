# Use the official Codespaces base image
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

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

# Install Neovim
RUN apt-get update && apt-get install -y neovim

# Copy the install script
COPY install.sh /install.sh

# Make the script executable
RUN chmod +x /install.sh

# Create directory for neovim
RUN mkdir -p ~/.local

# Set up workspace
WORKDIR /workspace

