# Terraform and Ansible Project for WordPress on Azure

This project aims to deploy a basic WordPress site on Azure using Terraform for infrastructure and Ansible for application configuration. The Azure infrastructure includes two virtual instances behind a load balancer and a managed relational database.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- An Azure account with authentication information configured.

## Usage Instructions

1. Clone this repository to your local machine.

2. Navigate to the `terraform/` directory and initialize your Terraform configuration using `terraform init`.

3. Customize the variables by copying the `terraform.tfvars.example` in `terraform.tfvars` and fill it as per your requirements.

4. Deploy the Azure infrastructure with Terraform using `terraform apply`.

5. Navigate to the `ansible/` directory.

6. Execute the Ansible playbook to configure WordPress on your virtual instances. Using the ssh private key file located in `ssh_private_key_output_path` you set in `terraform.tfvars`
```command
ansible-playbook -i hosts, -u $your_vm_admin_user --key-file $path_to_the_ssh_keyfile playbook.yml
```

7. Your WordPress site is now deployed and configured. You can access the virtual instances via the load-balancer public IP address.

That's it.

This should allow you to deploy a basic WordPress site on Azure using Terraform and Ansible. Be sure to further customize your WordPress configuration and secure your resources as needed.

## Contribution

Contributions are welcome! If you want to contribute to this project, please refer to Contributing.md file.