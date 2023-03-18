output "ec2_public_ip" {
  value = module.myapp-instance.instance.public_ip
}
