output "operators" {
  value = {
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical
  }
}

output "double_numbers" {
  value = local.double_numbers
}

output "even_numbers" {
  value = local.even_numbers
}

output "firstnames" {
  value = local.firstnames
}

output "fullnames" {
  value = local.fullnames
}

output "doubles_map" {
  value = local.doubles_map
}

output "even_map" {
  value = local.even_map
}

output "users_map" {
  value = local.users_map
}

output "users_map2" {
  value = local.users_map2
}

output "user_to_output_roles" {
  value = local.users_map2[var.user_to_output].roles
}

output "usernames_from_map" {
  value = local.usernames_from_map
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}

output "roles_from_splat" {
  value = local.roles_from_splat
}

output "roles_from_splat_with_values" {
  value = local.roles_from_splat_with_values
}

# functions outputs
output "example1" {
  value = startswith(lower(local.name), "john")
}

output "example2" {
  value = pow(local.age, 2)
}

output "example3" {
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name
}

output "example4" {
  value = jsonencode(local.my_object)
}
