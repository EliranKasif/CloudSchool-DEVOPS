output "main-instance_vault_sg_id"{
    value = aws_security_group.main-instance_vault.id
}

output "main-instance_consul_sg_id"{
    value = aws_security_group.main-instance_consul.id
}

output "main-instance_local_ipv4"{
    value = aws_instance.main-server_lc[0].private_ip
}