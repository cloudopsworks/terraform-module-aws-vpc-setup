##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
variable "bastion_size" {
  type    = string
  default = "t3a.micro"
}

variable "bastion_storage" {
  type    = string
  default = "10"
}

variable "bastion_state" {
  type    = string
  default = "stopped"
}