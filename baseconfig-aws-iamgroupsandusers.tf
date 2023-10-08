resource "aws_iam_group" "abc_admins" {
  name = "abc-admins"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "admins" {
  group      = aws_iam_group.abc_admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" //attach policies as necessary. This is for managed policies. 
}

resource "aws_iam_policy" "mfa_policy" { //requires all users to enable MFA before they can access any servies in the account. 
  name   = "manage_own_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.manage_own.json
}

resource "aws_iam_group_policy_attachment" "admin_mfa" {
  group      = aws_iam_group.abc_admins.name
  policy_arn = aws_iam_policy.mfa_policy.arn
}


resource "aws_iam_user" "admins" {
  count = length(var.abc_admins)
  name  = var.abc_admins[count.index]
  path  = "/"
}

resource "aws_iam_group_membership" "abc_admin" {
  name  = "abc-admin-group-membership"
  users = var.abc_admins
  group = aws_iam_group.abc_admins.name
}

