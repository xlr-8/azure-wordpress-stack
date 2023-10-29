
variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Region to deploy on"
  type        = string
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "site_url" {
  description = "URL of wordpress site"
  type        = string
}

variable "vm_sizing" {
  description = "Size of VMs to be deployed"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "mysql_sku_name" {
  type        = string
  default     = "B_Standard_B1s"
  description = "MySQL flexible server sku name. Refer to https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-service-tiers-storage."
}

variable "mysql_admin_login" {
  description = "MySQL Administrator account login"
  type        = string
}

variable "mysql_server_version" {
  type        = string
  default     = "5.7"
  description = "Version of MySQL to use"
}

variable "mysql_server_backup_retention_length" {
  type        = number
  default     = 7
  description = "MySQL flexible server backup duration in days. Defaults to 7."
}


variable "mysql_admin_password" {
  description = "MySQL Administrator account password"
  type        = string
}
variable "vm_admin_login" {
  description = "Wordpress Vms admin login"
  type        = string

}
variable "vm_admin_password" {
  description = "Wordpress Vms admin password"
  type        = string
}
variable "vm_image_publisher" {
  type        = string
  default     = "Canonical"
  description = "Webhost VM image publisher on Azure. Defaults to 'Canonical'"
}

variable "vm_image_offer" {
  type        = string
  default     = "UbuntuServer"
  description = "Webhost VM image offer on Azure. Defaults to 'UbuntuServer'"
}

variable "vm_image_sku" {
  type        = string
  default     = "16.04-LTS"
  description = "Webhost VM image SKU on Azure. Defaults to '16.04-LTS'"
}

variable "vm_image_version" {
  type        = string
  default     = "latest"
  description = "Webhost VM image version on Azure. Defaults to 'latest'"
}

variable "ansible_vars_output_path" {
  type        = string
  default     = "ansible_variables.yml"
  description = "Path where to output Ansible variables file."
}

variable "ansible_inventory_template_path" {
  type        = string
  default     = "templates/ansible_inventory.tftpl"
  description = "Path to ansible inventory template file."
}

variable "ansible_inventory_output_path" {
  type        = string
  default     = "hosts"
  description = "Path where to output ansible inventory."
}
variable "ssh_private_key_output_path" {
  type        = string
  description = "Path where to output ssh private key to use with ansible playbook."
}