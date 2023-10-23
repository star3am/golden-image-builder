#!/bin/bash

echo "Set Environment Variables"
export PIP_DISABLE_PIP_VERSION_CHECK=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export CRYPTOGRAPHY_DONT_BUILD_RUST=1
# INFO: Below is done in the Dockerfile
#       Uncomment if you are not using the Docker Image as the build agent
echo "Create Python Virtual Environment in /opt/venv"
python3 -m venv ansible-venv
echo "Activate Python Virtual Environment in /opt/venv"
source /opt/venv/bin/activate
echo "Check Python and Pip Versions"
python3 -V
pip3 -V
echo "Install Python Pip Packages"
pip3 install -r requirements.txt --no-cache-dir

# INFO: If you are testing be sure to pull down the Ansible Roles with Galaxy first
#       This is done as part of the CI/CD pipeline
# ansible-galaxy install -f -r ansible/roles/requirements.yml -p ansible/roles/
