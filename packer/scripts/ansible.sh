#!/bin/bash

echo "Set Environment Variables"
export PIP_DISABLE_PIP_VERSION_CHECK=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export CRYPTOGRAPHY_DONT_BUILD_RUST=1
echo "Create Python Virtual Environment in ./ansible-venv"
python3 -m venv ansible-venv
echo "Activate Python Virtual Environment in ./ansible-venv"
source ./ansible-venv/bin/activate
echo "Check Python and Pip Versions"
python3 -V
pip3 -V

ANSIBLE_FORCE_COLOR=1 ANSIBLE_LOAD_CALLBACK_PLUGINS=1 PYTHONUNBUFFERED=1 ansible-playbook "$@"
