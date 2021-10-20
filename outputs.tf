# What is my IP/DNS?

output "DogApp_IP" {
  value = "http://${aws_eip.DogoAL.public_ip}"
}