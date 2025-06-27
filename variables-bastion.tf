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