ARG DOTNET_VERSION="3.1.413"
ARG UBUNTU_RELEASE="jammy"

FROM ubuntu:${UBUNTU_RELEASE}

ARG DEBIAN_FRONTEND=noninteractive
ARG MIRROR="http://archive.ubuntu.com"

# UBUNTU_RELEASE must be redeclared because it is used before "FROM"
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG UBUNTU_RELEASE="jammy"
ARG UBUNTU_VERSION="22.04.2"
ARG TARGETPLATFORM
ARG PKGS="\
apt-transport-https \
apt-utils \
build-essential \
ca-certificates \
curl \
wget \
git \
gnupg \
gpg \
jq \
libffi-dev \
libssl-dev \
lsb-release \
make \
openssh-client \
python3-crcmod \
python3-dev \
python3-pip \
python3-virtualenv \
python3-venv \
shellcheck \
snapd \
software-properties-common \
tree \
unzip \
zip \
nano \
vim \
less \
dos2unix \
"

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Apt Updates
RUN apt update && \
    apt install --no-install-recommends -y ${PKGS} && \
    apt upgrade -y && \
    apt autoremove --purge -y

# packages.microsoft.com repo key
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Microsoft hosted agent uses a User `vsts` with UID `1001` and GID `117`
# https://github.com/microsoft/azure-pipelines-agent/issues/2043#issuecomment-524683461
ARG USER_ID="1001"
RUN adduser --disabled-password --gecos "" --shell /bin/bash --uid ${USER_ID} ubuntu

# packer
RUN wget -q -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt update && \
    apt install --no-install-recommends -y packer

# ansible
# Python virtual environment
# https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv ${VIRTUAL_ENV}
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"
# ansible and dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir



# hadolint
ARG HADOLINT_VERSION="v2.10.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=x86_64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=x86_64; fi && \
    curl -Lo /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-${ARCHITECTURE} && \
    chmod +x /usr/local/bin/hadolint

# tfenv
COPY --chown=ubuntu ./.terraform-version /opt/.terraform-version
RUN git clone --depth 1 https://github.com/tfutils/tfenv.git /opt/tfenv && \
    ln -s /opt/tfenv/bin/tfenv /usr/local/bin && \
    ln -s /opt/tfenv/bin/terraform /usr/local/bin && \
    mkdir -p /opt/tfenv/versions && \
    cd /opt && \
    dos2unix /opt/.terraform-version && \
    tfenv install && \
    chown -R ubuntu:root /opt/tfenv

# tfsec
ARG TFSEC_VERSION="0.58.14"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    curl -Lo /usr/local/bin/tfsec https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-${ARCHITECTURE} && \
    chmod +x /usr/local/bin/tfsec

# tflint
ARG TFLINT_VERSION="0.30.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    curl -Lo /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_${ARCHITECTURE}.zip && \
    unzip /tmp/tflint.zip -d /usr/local/bin && \
    python3 -m pip install --no-cache-dir --quiet yamllint

# tflint azurerm plugin
ARG TFLINT_AZURERM_PLUGIN="0.12.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    mkdir -p /home/ubuntu/.tflint.d/plugins && \
    chown -R ubuntu:ubuntu /home/ubuntu/.tflint.d && \
    curl -Lo /tmp/tflint-ruleset-azurerm_linux_${ARCHITECTURE}.zip https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v${TFLINT_AZURERM_PLUGIN}/tflint-ruleset-azurerm_linux_${ARCHITECTURE}.zip && \
    unzip /tmp/tflint-ruleset-azurerm_linux_${ARCHITECTURE}.zip -d /home/ubuntu/.tflint.d/plugins

# terraform-docs
ARG TERRAFORM_DOCS_VERSION="0.16.0"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm/v8" ]; then ARCHITECTURE=arm64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    curl -Lo /tmp/terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${ARCHITECTURE}.tar.gz && \
    cd /tmp && \
    tar -xzf terraform-docs.tar.gz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/local/bin/terraform-docs

# aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# https://aws.amazon.com/blogs/developer/aws-cli-v2-now-available-for-linux-arm/
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=x86_64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=aarch64; elif [ "$TARGETPLATFORM" = "linux/arm64/v8" ]; then ARCHITECTURE=aarch64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; else ARCHITECTURE=x86_64; fi && \
    curl -Lo "/tmp/awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-${ARCHITECTURE}.zip" && \
    cd /tmp && \
    unzip -qq awscliv2.zip && \
    ./aws/install --update

# gcloud cli https://cloud.google.com/sdk/docs/install#deb
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y

# azure cli
# BUG: https://github.com/Azure/azure-cli/issues/7368 so installing via pip
RUN python3 -m pip install --no-cache-dir --quiet --upgrade azure-cli

# pre-commit https://pre-commit.com/#install
RUN python3 -m pip install --no-cache-dir --quiet --upgrade --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org git+https://github.com/pre-commit/pre-commit.git@v2.20.0

# cleanup
RUN apt autoremove --purge -y && \
    find /opt /usr/lib -name __pycache__ -print0 | xargs --null rm -rf && \
    rm -rf /var/lib/apt/lists/*

USER ubuntu
ENV PATH="$PATH:/home/ubuntu/.local/bin"

WORKDIR /app
