locals {
  firstnames_from_splat        = toset(var.objects_list[*].firstname)
  roles_from_splat             = [for username, user_props in local.users_map2 : user_props.roles]
  roles_from_splat_with_values = values(local.users_map2)[*].roles
}
