output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "aws_region" {
  value = data.aws_region.current.name
}

output "instance_id" {
  value = aws_instance.vmubuntu[*].id
}

output "instance_public_ip" {
  value = aws_instance.vmubuntu[*].public_ip
}

output "instance_private_ip" {
  value = aws_instance.vmubuntu[*].private_ip
}

output "instance_subnet_id" {
  value = aws_instance.vmubuntu[*].subnet_id
}
