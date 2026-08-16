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
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::904464083807:user/dev-console-admin"]
    }
  }
}

resource "aws_iam_role" "roles" {
  for_each = local.role_policies
  name     = each.key

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

