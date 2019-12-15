# Server Configuration Management using Ansible

## Overview

In this task I created an ansible playbook for configuring packages on a centos7 server.

## Ansible Playbook configuration guidelines

1. Installed ansible on the ansible server using the command

```bash
$ sudo apt-get update
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible -y
```

2. Generate SSH keys using the command given below:

```
$ ssh-keygen
```
Follow the steps given by above command.

3. Add the ssh key to the node(s) using the command given below:

```bash
ssh-copy-id NODE_1_IP
```

4. Configure nodes using the steps given below:

```bash

# edit the /etc/ansible/host files and add the content given below:
[nodes]
NODE_1_IP
NODE_2_IP
```

5. Ping the nodes for accesibility:

```bash
ansible -m ping all
```

OR

```bash
ansible -m ping nodes
```

6. Run the ansible playbook using the command given below:

```bash
ansible-playbook <playbook-name> -v
```

7. Once the playbook execution is complete access each to check whether packages are installed or not:

```bash
ssh <username>@NODE_1_IP
```


## Refrences

1. https://docs.ansible.com/ansible/latest/user_guide/playbooks_error_handling.html
2. https://docs.ansible.com/ansible/latest/modules/package_module.html#parameters
3. https://docs.ansible.com/ansible/latest/modules/yum_module.html
4. https://docs.ansible.com/ansible/latest/modules/apt_module.html
5. https://www.techrepublic.com/article/how-to-install-ansible-on-ubuntu-server-18-04/