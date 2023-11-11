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
Simulate Pipeline
make format
--- terraform-format
>>> Exec (terraform fmt -recursive -diff)
--- packer-format
>>> Exec (packer fmt -recursive -diff packer)
make lint
--- terraform-lint
>>> Exec (terraform fmt -check -recursive -diff)
--- tflint
--- tflint-module (terraform/awx-ansible-tower-instance)
>>> Exec (tflint terraform/awx-ansible-tower-instance)
--- tflint-module (terraform/azure-shared-image-gallery)
>>> Exec (tflint terraform/azure-shared-image-gallery)
--- yamllint
>>> Exec (yamllint -f auto .)
make tflint
--- tflint
--- tflint-module (terraform/awx-ansible-tower-instance)
>>> Exec (tflint terraform/awx-ansible-tower-instance)
--- tflint-module (terraform/azure-shared-image-gallery)
>>> Exec (tflint terraform/azure-shared-image-gallery)
make init-all
--- init-all ("./")

Initializing the backend...
Upgrading modules...
Downloading registry.terraform.io/star3am/hashiqube/hashicorp 1.1.3 for awx_ansible_tower...
- awx_ansible_tower in .terraform/modules/awx_ansible_tower
- awx_ansible_tower.aws_hashiqube in .terraform/modules/awx_ansible_tower/modules/aws-hashiqube
- awx_ansible_tower.azure_hashiqube in .terraform/modules/awx_ansible_tower/modules/azure-hashiqube
- awx_ansible_tower.gcp_hashiqube in .terraform/modules/awx_ansible_tower/modules/gcp-hashiqube

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "3.57.0, ~> 3.57"...
- Finding hashicorp/google versions matching "~> 4.66"...
- Finding hashicorp/null versions matching "~> 3.0"...
- Finding hashicorp/http versions matching "~> 3.4"...
- Finding hashicorp/external versions matching "~> 2.3"...
- Finding hashicorp/aws versions matching "~> 4.67"...
- Using previously-installed hashicorp/http v3.4.0
- Using previously-installed hashicorp/external v2.3.1
- Using previously-installed hashicorp/aws v4.67.0
- Using previously-installed hashicorp/azurerm v3.57.0
- Using previously-installed hashicorp/google v4.84.0
- Using previously-installed hashicorp/null v3.2.1

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 3.57"...
- Installing hashicorp/azurerm v3.80.0...
- Installed hashicorp/azurerm v3.80.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
make validate
--- validate
Running terraform validate on terraform/awx-ansible-tower-instance
Success! The configuration is valid.

Running terraform validate on terraform/azure-shared-image-gallery
Success! The configuration is valid.

make clean
--- clean
>>> Exec (find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;)
>>> Exec (find . -type f -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;)
>>> Exec (rm -fr /opt/terragrunt-cache/*)
make docs
--- docs
--- docs-module (terraform/awx-ansible-tower-instance)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "terraform/awx-ansible-tower-instance" > "terraform/awx-ansible-tower-instance/README.md")
--- docs-module (terraform/azure-shared-image-gallery)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "terraform/azure-shared-image-gallery" > "terraform/azure-shared-image-gallery/README.md")
make tfsec
--- tfsec
Running tfsec on terraform/awx-ansible-tower-instance
Warning: A tfvars file was found but not automatically used. Did you mean to specify the --tfvars-file flag?
WARNING: Failed to load module: missing module with source 'star3am/hashiqube/hashicorp' -  try to 'terraform init' first

  times
  ------------------------------------------
  disk i/o             2.471109ms
  parsing HCL          28.931µs
  evaluating values    222.736µs
  running checks       1.01559ms

  counts
  ------------------------------------------
  files loaded         3
  blocks               9
  modules              0

  results
  ------------------------------------------
  critical             0
  high                 0
  medium               0
  low                  0
  ignored              0

No problems detected!

Running tfsec on terraform/azure-shared-image-gallery

  times
  ------------------------------------------
  disk i/o             3.043562ms
  parsing HCL          10.715µs
  evaluating values    257.546µs
  running checks       1.433383ms

  counts
  ------------------------------------------
  files loaded         4
  blocks               17
  modules              0

  results
  ------------------------------------------
  critical             0
  high                 0
  medium               0
  low                  0
  ignored              0

No problems detected!

pre-commit run -a
check for added large files..............................................Passed
check for merge conflicts................................................Passed
check vcs permalinks.....................................................Passed
forbid new submodules................................(no files to check)Skipped
don't commit to branch...................................................Passed
fix end of files.........................................................Passed
trim trailing whitespace.................................................Passed
check yaml...............................................................Passed
check for merge conflicts................................................Passed
check for broken symlinks................................................Passed
check json...............................................................Passed
check for case conflicts.................................................Passed
mixed line ending........................................................Passed
detect aws credentials...................................................Passed
detect private key.......................................................Passed
Terraform fmt............................................................Passed
Terraform docs...........................................................Passed
Lint Dockerfiles.........................................................Passed
```

## Contributing

Clone this Repo, and install VSCode and the Dev Containers extension. 

Make some changes in your own branch and run in the VSCode Terminal: 
`./run.sh`

Once successfull, push to your branch and create a PR. 

Shout if you need help! 

## Testing

Run in the VSCode Terminal: 
`./run.sh`

## More info

In this post I will help you go from Zero to Hero building Golden Images or Standard Operating Environments. This Topic is complex by nature, since it spans, multiple Operating Systems, Multiple Clouds and Multiple Technologies, but, if you walk this through, you will come out the other side a Top Gun Engineer, able to build Any Operating System, on Any Cloud with extreme confidence. If you get stuck, please reach out to me on my Linkedin profile https://www.linkedin.com/in/riaannolan/ and I will help you, just like others have helped me before.

Ok, let’s dive in.

The common theme across many DevOps / Infrastructure as Code / Configuration as Code / Automation projects is versioning.

We want to create a versioned artefact that we can deploy, and our Infrastructure or Golden images are no different.

Enter versioned artefacts.

Simply put, we want to move fast, develop fast, while keeping versioned checkpoints (artefacts) so to speak, that we can deploy, test and if necessary roll back or roll forward.

Golden images / Standard Operating Environments (SOEs) are much the same. Gone are the days of manualley maintaining Golden Images or Standard Operating Environments SOEs.

TL;DR The code can be found here:

https://github.com/star3am/golden-image-builder

![Golden Image Builder GIB](images/gib-logo.png?raw=true "Golden Image Builder GIB")

I'd like to introduce you to my take on this whole Golden Image thing, building versioned Standard Operating Environments SOEs.

But before I delve into it, there is a concept I'd like to run past you.

- Day 0 — Building an Image (SOE) This Image is not "live" or "running" yet.
- Day 1 — The Image is now booted into a VM / Container. It is now live and needs to register to end points e.g Monitoring / Domain join / OU Transition for Group Policies to take place.
- Day 2 onwards — Something needs to change in this running Image VM or Container e.g Yum, Apt or Windows Updates, configuration changes, Certificate rotations, anything at all.
Candidates for this project are: Build Agent VMs, POS systems, Kubernetes Worker Nodes, VMs that run workloads, Point of Sale machines, really any VM or Container that has to be spun up in the 100s or 1000s of times.

In addition to this Day 0, Day 1 and Day 2 dilemma, we need to consider complexity. The more complex something is, the more error prone it becomes the harder it is to manage.

For that reason, we want to keep our development toolchain standardised and settle on the minimum languages to use, for that reason, I’ve picked:

- HCL — Hashicorp Configuration Language (With HCL you can write Terraform Modules and Packer Templates)
- YAML — Yet Another Markup Language (With YAML you can write Automation Pipelines (Github Actions, Gitlab, Azure DevOps, Circle CI etc.) and Ansible Roles and Playbooks)
Enter Automation Pipelines + Packer + Ansible + Terraform + AWX Ansible Tower.

![Golden Image Builder GIB](images/packer-build.png?raw=true "Golden Image Builder GIB")

Packer, Ansible, Terraform — This Trio of Technology can configure and build any Operating System, on any Cloud, and can be used locally as a Top Gun Development Environment! (See my post about Top Gun Terraform Development Environments)

So what is HashiCorp Packer?

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel. Packer does not replace configuration management like Chef or Puppet. In fact, when building images, Packer is able to use tools like Chef or Puppet to install software onto the image.

A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include AMIs for EC2, VMDK/VMX files for VMware, OVF exports for VirtualBox, etc.

What is RedHat Ansible?

Red Hat® Ansible® Automation Platform is an end-to-end automation platform to configure systems, deploy software, and orchestrate advanced workflows.

What is HashiCorp Terraform?

Terraform is an infrastructure-as-code software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language.

Going back to our Day 0, Day 1 and Day 2 concept, let's explain where we use what tool.

- Day 0 — Automation Pipelines + Packer + Ansible
- Day 1 — Automation Pipelines + Terraform + Ansible
- Day 2 onwards — Automation Pipelines + Terraform + AWX Ansible Tower
For Autiditng, Compliance and Visibility I am using Terraform Cloud and AWX Ansible Tower. Let's quickly address what those tools are.

What is Terraform Cloud

Terraform Cloud is a Web Interface for Terraform. It has great features such as Single Sign on, Remote AND ENCRYPTED state storage, Workspaces, Explorer (to see which workspaces failed, and which versions of modules the workspaces are using, and MUCH, MUCH more)

What is AWX Ansible Tower

AWX Ansible Tower is a Web Interface for Ansible. It has great features such as Single Sign on, a Web interface into your Ansible Jobs, Smart Inventories, Credentials, Projects and Secret Engines.

Ok! So enough of the theory! Let's Do this!

1. We Use VSCode Dev Containers (Meaning you don't need to install Ansible, Packer and Terraform, it's installed via a Dockerfile and VSCode will drop you into that container.)

![Golden Image Builder GIB](images/versions-devcontainer.png?raw=true "Golden Image Builder GIB")

2. We use Github Actions for our CI/CD Automation Pipeline and you can see the whole pipeline file here: https://github.com/star3am/golden-image-builder/blob/master/.github/workflows/pipeline.yml

![Golden Image Builder GIB](images/github-actions-pipeline.png?raw=true "Golden Image Builder GIB")

3. We use the same Dockerfile for our Build Agent and Developer Environment, meaning, we get consistent results every time. You can view the Dockerfile here: https://github.com/star3am/golden-image-builder/blob/master/Dockerfile

![Golden Image Builder GIB](images/github-actions-docker-build-step.png?raw=true "Golden Image Builder GIB")

4. Our Packer Templates can build a Golden Image / Standard Operating Environment SOE on any popular Cloud and you can see my Ubuntu 22.04 Packer Template here:
https://github.com/star3am/golden-image-builder/blob/master/packer/linux/ubuntu/ubuntu-2204.pkr.hcl

![Golden Image Builder GIB](images/packer-build.png?raw=true "Golden Image Builder GIB")

5. Our Ansible Roles are "Pulled Down" or "Installed" with Ansible Galaxy

```
 - name: Ansible Galaxy install roles
   run: ansible-galaxy install -f -r ansible/roles/requirements.yml -p ansible/roles/
```

and the requirements.txt looks like

```
---
- src: 'https://github.com/ansible-lockdown/RHEL8-CIS'
  version: '2.5.1'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/RHEL7-CIS'
  version: '1.2.3'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/UBUNTU22-CIS'
  version: '1.2.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/UBUNTU20-CIS'
  version: '2.1.1'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/UBUNTU18-CIS'
  version: '1.4.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/Windows-2016-CIS'
  version: '1.2.1'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/Windows-2019-CIS'
  version: '1.3.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/Windows-2022-CIS'
  version: '1.0.0'
  scm: 'git'

- src: 'https://github.com/star3am/ansible-role-win_openssh'
  version: 'ssh-playbook-test'
  scm: 'git'

- src: 'https://github.com/star3am/ansible-role-example-role'
  version: 'master'
  scm: 'git'
```

6. My Ansible-role-example-role supports, Windows, Yum and Debian based systems, and basically just add an ansible user to the system and it writes a 'Fingerprint' to the Image, meaning that running VMs can be tracked back to the original build and versions.

```
ubuntu@hashiqube-aws:~$ cat /build-202311100026.json  | jq
{
  "inventory_file": "/tmp/packer-provisioner-ansible4259354685",
  "inventory_dir": "/tmp",
  "ansible_host": "127.0.0.1",
  "ansible_user": "ubuntu",
  "ansible_port": 41081,
  "inventory_hostname": "none",
  "inventory_hostname_short": "none",
  "group_names": [
    "ungrouped"
  ],
  "ansible_facts": {
    "system": "Linux",
    "kernel": "6.2.0-1015-aws",
    "kernel_version": "#15~22.04.1-Ubuntu SMP Fri Oct  6 21:37:24 UTC 2023",
    "machine": "x86_64",
    "python_version": "3.10.12",
    "fqdn": "ip-172-31-5-254.ap-southeast-2.compute.internal",
    "hostname": "ip-172-31-5-254",
    "nodename": "ip-172-31-5-254",
    "domain": "ap-southeast-2.compute.internal",
    "userspace_bits": "64",
    "architecture": "x86_64",
    "userspace_architecture": "x86_64",
    "machine_id": "6f039c13c0ac4848a55d23f834de86b8",
    "is_chroot": false,
    "virtualization_type": "xen",
    "virtualization_role": "guest",
    "virtualization_tech_guest": [
      "xen"
    ],
    "virtualization_tech_host": [],
    "distribution": "Ubuntu",
    "distribution_release": "jammy",
    "distribution_version": "22.04",
    "distribution_major_version": "22",
    "distribution_file_path": "/etc/os-release",
    "distribution_file_variety": "Debian",
    "distribution_file_parsed": true,
    "os_family": "Debian",
...
```

7. Once the Image has been built I use Terraform and Hashiqube’s Multi Cloud Terraform https://hashiqube.com/ and https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest module to spin up HashiQube on this new Base AMI (Our Golden Image) — I do this for a few reasons:

- I need AWX Ansible Tower to showcase some additional functionality and HashiQube already has AWX Ansible Tower running on top of Kubernetes (Minikube) see: https://hashiqube.com/ansible-tower/README

- I use Terraform to handle all my Infreastructure as Code projects and my main.tf can be found here https://github.com/star3am/golden-image-builder/tree/master/terraform/awx-ansible-tower-instance and it looks like:

```
module "awx_ansible_tower" {
  source                     = "star3am/hashiqube/hashicorp"
  deploy_to_aws              = true
  aws_instance_type          = "t2.large"
  use_packer_image           = var.use_packer_image
  deploy_to_azure            = false
  deploy_to_gcp              = false
  debug_user_data            = true
  ssh_public_key             = var.ssh_public_key
  ssh_private_key            = var.ssh_private_key
  debug_allow_ssh_cidr_range = "0.0.0.0/0"
  whitelist_cidr             = "101.189.198.17/32"
  vagrant_provisioners       = "basetools,docker,minikube,ansible-tower"
}
```

8. I use Terraform Cloud for my remote Terraform Runs, it's free and blazing fast! https://app.terraform.io

![Golden Image Builder GIB](images/terraform-cloud-run.png?raw=true "Golden Image Builder GIB")

9. I use AWX Ansible Tower to do my Ansible Runs and you can log into the AWX Ansible Tower web interface on the http://Instance-IP:8043 with the username: admin and the password which is outputted on the Terraform Run

![Golden Image Builder GIB](images/terraform-cloud-run-ansible-output.png?raw=true "Golden Image Builder GIB")

And once we log in, we can see our AWX Ansible Tower Dashboard and our successful job run, which was triggered by Terraform

![Golden Image Builder GIB](images/ansible-tower-job-run.png?raw=true "Golden Image Builder GIB")

Example Terraform Code to trigger an Ansible Run via a Null_Resource

```
variable "tower_cli_remote" {
  type    = string
  default = "~/.local/bin/awx"
}

variable "tower_cli_local" {
  type    = string
  default = "/Users/riaannolan/bin/awx"
}

variable "tower_host" {
  type    = string
  default = "https://10.9.99.10:8043/"
}

data "external" "tower_token" {
  program = ["/bin/bash", "-c", "${var.tower_cli_local} login --conf.host ${var.tower_host} --conf.insecure --conf.username admin --conf.password \"password\""]
}

locals {
  timestamp = timestamp()
}

resource "null_resource" "awx_cli" {
  triggers = {
    timestamp = local.timestamp
  }

  provisioner "remote-exec" {
    inline = [
      "${var.tower_cli_remote} --conf.host ${var.tower_host} -f human job_templates launch 9 --monitor --filter status --conf.insecure --conf.token ${data.external.tower_token.result.token}",
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
      host        = "10.9.99.10"
    }
  }
  
  provisioner "local-exec" {
    command = "${var.tower_cli_local} --conf.host ${var.tower_host} -f human job_templates launch 9 --monitor --filter status --conf.insecure --conf.token ${data.external.tower_token.result.token}"
  }
}
```

10. You can now build Versioned Golden Images / Standard Operating Environments SOEs — ALL in CODE!!!

Thank you for your time, to go through this how-to, I hope that you have enjoyed it as much as I did putting it together.



## Links
- https://medium.com/@riaan.nolan/gib-the-golden-image-builder-87090b720a89
- https://github.com/star3am/golden-image-builder
- https://hashiqube.com

## Force Build
001

