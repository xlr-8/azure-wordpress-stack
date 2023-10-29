# azure-wordpress-stack

renseigner tfvars
Exécutez Terraform pour créer les ressources Azure :

terraform init
terraform apply

Configure you host file with outputs
Ensuite, utilisez Ansible pour déployer WordPress sur les VM Azure :

bash
Copy code
ansible-playbook -i azure_vm_ips, -u adminuser -K wordpress.yml
Assurez-vous de remplacer azure_vm_ips par les adresses IP des VM créées par Terraform.

Cela devrait vous permettre de déployer un site WordPress de base sur Azure à l'aide de Terraform et Ansible. Assurez-vous de personnaliser davantage votre configuration WordPress et de sécuriser vos ressources selon vos besoins.
