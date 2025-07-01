FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# use this Dockerfile to install additional tools you might need, e.g.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# Install AWS CLI
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        curl \
        unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy and setup AWS SSO check script
COPY aws-sso-check.sh /usr/local/bin/aws-sso-check.sh
RUN chmod +x /usr/local/bin/aws-sso-check.sh

# Register the script to run on bash startup for vscode user
RUN echo 'if [ -f /usr/local/bin/aws-sso-check.sh ]; then /usr/local/bin/aws-sso-check.sh; fi' >> /etc/bash.bashrc
