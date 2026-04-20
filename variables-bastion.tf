##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# bastion:                         # (Optional) Bastion host configuration. Default: {} (no bastion created)
#   create: false                  # (Optional) Create a bastion host in the first public subnet. Default: false
#   vm_size: "t3a.micro"           # (Optional) EC2 instance type. Default: "t3a.micro"
#   disk_size: 10                  # (Optional) Root EBS volume size in GB. Default: 10
#   state: "stopped"               # (Optional) Desired instance state. Values: running, stopped. Default: "stopped"
#   vendor: "ubuntu"               # (Optional) OS vendor for AMI selection. Values: ubuntu, amazon, centos, rhel. Default: "ubuntu"
#   docker_version: "26.0"         # (Optional) Docker engine version to install via cloud-init. Default: "26.0"
#   devops_accelerator: false      # (Optional) Publish bastion instance-id, key, and SG to SSM Parameter Store
#                                  #            for use with CloudOps Works DevOps Accelerator. Default: false
#   extra_iam: []                  # (Optional) Additional IAM policy statement objects attached to the bastion role. Default: []
#   #  - sid: "ExtraS3Access"      #   sid: (Optional) Statement ID
#   #    effect: "Allow"           #   effect: (Optional) Values: Allow, Deny. Default: Allow
#   #    actions:                  #   actions: (Required) List of IAM action strings
#   #      - "s3:GetObject"
#   #    resources:                #   resources: (Required) List of ARN strings
#   #      - "arn:aws:s3:::my-bucket/*"
variable "bastion" {
  description = "Bastion host configuration. All attributes optional; omit the entire block or set create=false to skip. Default: {}"
  type = object({
    create             = optional(bool, false)         # (Optional) Create a bastion host in the first public subnet. Default: false
    vm_size            = optional(string, "t3a.micro") # (Optional) EC2 instance type for the bastion. Default: "t3a.micro"
    disk_size          = optional(number, 10)          # (Optional) Root EBS volume size in GB. Default: 10
    state              = optional(string, "stopped")   # (Optional) Desired instance state. Values: running, stopped. Default: "stopped"
    vendor             = optional(string, "ubuntu")    # (Optional) OS vendor. Values: ubuntu, amazon, centos, rhel. Default: "ubuntu"
    docker_version     = optional(string, "26.0")      # (Optional) Docker engine version to install. Default: "26.0"
    devops_accelerator = optional(bool, false)         # (Optional) Register bastion metadata in SSM Parameter Store for DevOps Accelerator. Default: false
    extra_iam          = optional(any, [])             # (Optional) Additional IAM policy statement objects for the bastion role. Default: []
  })
  default = {}

  validation {
    condition     = contains(["ubuntu", "amazon", "centos", "rhel"], try(var.bastion.vendor, "ubuntu"))
    error_message = "bastion.vendor must be one of 'ubuntu', 'amazon', 'centos', or 'rhel'."
  }
}
