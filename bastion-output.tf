##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
output "bastion_key" {
  value = tls_private_key.keypair_gen_bastion.*.public_key_openssh
}

output "bastion_public_address" {
  value = aws_instance.bastion_server.*.public_dns
}

output "bastion_public_ip" {
  value = aws_instance.bastion_server.*.public_ip
}
