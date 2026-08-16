output "users" {
  value = local.users_from_yaml
}

output "passwords" {
  value     = { for user, user_login in aws_iam_user_login_profile.users : user => user_login.password }
  sensitive = true
}

output "policies" {
  value = local.role_policies_list
}
