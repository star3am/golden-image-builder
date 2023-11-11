# Golden Image Builder (GIB)

This repository forms the basis of my own personal implimentation of a Golden Image Builder.

It's made up of pre-coded modules to get you started quickly.

It also uses tools, such as Packer, TFEnv, Terraform Docs, Linters, VSCode's Dev / Remote containers and many more to provide effectively a Packer / Ansible / Terraform / DevOps engineer development lab to develop and test Packer Templates, Ansible Roles and Playbooks, and, Terraform Modules.

You are most welcome and in fact encouraged to contribute back to this repository.

![Golden Image Builder GIB](images/gib-logo.png?raw=true "Golden Image Builder GIB")

## Demo

## Features

This repository uses some best practice tools to help us with our Packer Templates, Ansible Playbooks and Roles and Terraform modules. Tools such as TFENV which automatically installs the correct Terraform Version, Terraform Docs and Terraform Lint and Packer Lint, the comprehensive feature list is detailed below.

| Product | State |
|-------|---------|
| VSCode Dev Container | ✓ |
| Pre-Commit | ✓ |
| Packer | ✓ |
| Ansible | ✓ |
| Molecule | ✓ |
| AWX Ansible Tower | ✓ |
| Terratest | ✘ |
| Terraform | ✓ |
| TFEnv | ✓ |
| TGEnv | ✓ |
| TFsec | ✓ |
| AWS | ✓ |
| GCP | ✓ |
| Azure | ✓ |
| Custom | ✓ |
| Terraform Lint | ✓ |
| Terraform Format | ✓ |
| Terraform Validate | ✓ |
| Terraform Docs | ✓ |

- Pre-commit: Runs pre-commit with the given config in `.pre-commit-config.yaml.

- Linters: terraform-lint packer-lint tflint yamllint

- Packer lint: packer fmt -check -recursive -diff

- Terraform lint: terraform fmt -check -recursive -diff

- Terraform format: terraform fmt -check -recursive -diff

- Clean: Clean up .terraform and .terrgrunt-cache folders

- Terraform docs: Create README.md files for each Terraform Module on the fly, generated from your code

- Terraform Plan: Using Terragrunt we run a plan on all modules

## Getting started

Please install the following software

- Docker Desktop https://www.docker.com/products/docker-desktop/
- Visual Studio Code https://code.visualstudio.com/download (with Remote development in Containers extension) https://code.visualstudio.com/docs/remote/containers-tutorial
- Clone this repository
- Now Open VSCode and Open this repository

:bulb: Let's look at some Screenshots of Opening your project

In VSCode, click File -> Open Folder and navigate to this project
![VSCode open repository folder](images/vscode-open-repository-folder.png?raw=true "VSCode open repository folder")

If you have installed the Devcontainer Extension in the previous step, you'd see a Notification, bottom Right.

__Folder contains a Dev Container configuration file. Reopen folder to develop in a container__ and click `Reopen in Container`

![VSCode open repository folder open in devcontainer](images/vscode-open-repository-folder-open-in-devcontainer.png?raw=true "VSCode open repository folder open in devcontainer")

You will see the Docker Build log bottom right and once done, you will see the files of the project in VSCode.

![VSCode open repository folder open in devcontainer docker build
log](images/vscode-open-repository-folder-open-in-devcontainer-build-log.png?raw=true "VSCode open repository folder open in
devcontainer docker build log")

Now you can open a new Terminal. This will launch a new terminal inside the container, you will note that Terraform, Terragrunt and all the tools this project needs has already been installed for you.

![VSCode open repository folder open in devcontainer new Terminal](images/vscode-open-repository-folder-open-in-devcontainer-new-terminal.png?raw=true "VSCode open repository folder open in devcontainer new Terminal")

Now you need to Authenticate to your Clouds, see: __Authenticating__ below.

## Authenticating

Somewhere someone or something has to authenticate against the clouds, the pipeline will take care of this for you, however if you are developing locally, you need to take care of this yourself.

```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_REGION=

export GOOGLE_CREDENTIALS=

export ARM_CLIENT_ID=
export ARM_CLIENT_SECRET=
export ARM_SUBSCRIPTION_ID=
export ARM_TENANT_ID=
```

## Example output

When you run ./run.sh you will get the following output

`ubuntu@0c9b71981e0b:/app$ ./run.sh`

```

```

## Contributing

### Adding/Changing a Module

## Testing

## Debugging

## FAQs

- Why are You using a Mono Repo?
I try to avoid code duplication and as a small team, to avoid this developers commit hell cycle, I opted for a Mono repo, you are welcome to split it up. You can always use the individual modules using the Terraform Source `source = "git::git@github.com:star3am/terraform-modules-library.git//aws/modules/debug?ref=main"`

## Gotchas

## Thanks!

## Force Build
001
