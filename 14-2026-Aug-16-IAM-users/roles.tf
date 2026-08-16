locals {
  role_policies = {
    readonly = [
      "ReadOnlyAccess"
    ]
    admin = [
      "AdministratorAccess"
    ]
    auditor = [
      "SecurityAudit"
    ]
    developer = [
      "AmazonVPCFullAccess",
      "AmazonEC2FullAccess",
      "AmazonRDSFullAccess"
    ]
  }

  role_policies_list = flatten([
    for role, policies in local.role_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])

  # Pre-calculate allowed user ARNs per role
  role_user_arns = {
    for role in keys(local.role_policies) : role => [
      for username in keys(aws_iam_user.users) :
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${username}"
      if contains(lookup(local.users_map, username, []), role)
    ]
  }
}

data "aws_caller_identity" "current" {}

# 1. Define Assume Role Policy
data "aws_iam_policy_document" "assume_role_policy" {
  for_each = toset(keys(local.role_policies))

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      # If no users match, fallback to root account so the policy syntax remains valid
      identifiers = length(local.role_user_arns[each.value]) > 0 ? local.role_user_arns[each.value] : ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

# 2. Create IAM Roles
resource "aws_iam_role" "roles" {
  for_each = toset(keys(local.role_policies))

  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[each.value].json
}

# 3. Fetch Managed Policies
data "aws_iam_policy" "managed_policies" {
  for_each = toset(flatten(values(local.role_policies)))
  arn      = "arn:aws:iam::aws:policy/${each.value}"
}

# 4. Attach Policies to Roles
resource "aws_iam_role_policy_attachment" "role_policy_attachments" {
  count      = length(local.role_policies_list)
  role       = aws_iam_role.roles[local.role_policies_list[count.index].role].name
  policy_arn = data.aws_iam_policy.managed_policies[local.role_policies_list[count.index].policy].arn
}
