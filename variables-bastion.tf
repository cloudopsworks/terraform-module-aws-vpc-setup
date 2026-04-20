##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "bastion" {
  description = "Bastion host configuration"
  type = object({
    create             = optional(bool, false)         # (Optional) Create a bastion host in the first public subnet, default: false
    vm_size            = optional(string, "t3a.micro") # (Optional) EC2 instance type for the bastion, default: "t3a.micro"
    disk_size          = optional(number, 10)          # (Optional) Root EBS volume size in GB, default: 10
    state              = optional(string, "stopped")   # (Optional) Desired instance state: running or stopped, default: "stopped"
    vendor             = optional(string, "ubuntu")    # (Optional) OS vendor: ubuntu, amazon, centos, or rhel, default: "ubuntu"
    docker_version     = optional(string, "26.0")      # (Optional) Docker engine version to install, default: "26.0"
    devops_accelerator = optional(bool, false)         # (Optional) Publish bastion metadata to SSM Parameter Store for DevOps Accelerator, default: false
    extra_iam          = optional(any, [])             # (Optional) Additional IAM policy statement objects to attach to the bastion IAM role
  })
  default = {}

  validation {
    condition     = contains(["ubuntu", "amazon", "centos", "rhel"], try(var.bastion.vendor, "ubuntu"))
    error_message = "bastion.vendor must be one of 'ubuntu', 'amazon', 'centos', or 'rhel'."
  }
}
