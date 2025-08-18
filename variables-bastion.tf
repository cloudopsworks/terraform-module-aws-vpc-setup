##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
variable "bastion_size" {
  description = "The instance type for the bastion host. Default is 't3a.micro'."
  type        = string
  default     = "t3a.micro"
}

variable "bastion_storage" {
  description = "The size of the EBS volume for the bastion host in GB. Default is '10'."
  type        = string
  default     = "10"
}

variable "bastion_state" {
  description = "The state of the bastion host. Can be 'running' or 'stopped'. Default is 'stopped'."
  type        = string
  default     = "stopped"
}

variable "devops_accelerator" {
  description = "Flag to enable DevOps Accelerator features. If true, additional resources and configurations for DevOps Accelerator will be applied."
  type        = bool
  default     = false
}

variable "bastion_vendor" {
  description = "The vendor for the bastion host. Default is 'ubuntu'."
  type        = string
  default     = "ubuntu"
  validation {
    condition     = contains(["ubuntu", "amazon", "centos", "rhel"], var.bastion_vendor)
    error_message = "The bastion_vendor must be one of 'ubuntu', 'amazon', 'centos', or 'rhel'."
  }
}
