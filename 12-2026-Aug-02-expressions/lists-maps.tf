# create a local users_map, which transforms the var.users list into a map where the username property becomes the key in the map, and the role property becomes the value. 
# locals {
#   users_map = {
#     for user_info in var.users : user_info.username => user_info.role
#   }
# }

# Having a duplicated key will throw an error. Use the ellipsis operator at the end of user_info.role to group together all the roles for a single username under the same map key.
locals {
  users_map = {
    for user_info in var.users : user_info.username => user_info.role...
  }
}

# a new map with the following structure: <key> => { roles = <roles list> }
locals {
  users_map2 = {
    for username, roles in local.users_map : username => {
      roles = roles
    }
  }
}

locals {
  usernames_from_map = [for username, roles in local.users_map : username]
  # We can also use usernames_from_map = keys(local.users_map) instead of manually creating the list!
}

