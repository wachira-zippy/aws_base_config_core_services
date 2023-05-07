resource "aws_iam_group" "silicon_admin" {
  name = "silicon_overdrive"
  path = "/"
}

resource "aws_iam_group" "client_admin" {
  name = var.client_name
  path = "/"
}

resource "aws_iam_group_policy_attachment" "silicon_admin" {
  group      = aws_iam_group.silicon_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "client_admin" {
  group      = aws_iam_group.client_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "mfa_policy" {
  name   = "manage_own_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.manage_own.json
}

resource "aws_iam_group_policy_attachment" "silicon_admin_mfa" {
  group      = aws_iam_group.silicon_admin.name
  policy_arn = aws_iam_policy.mfa_policy.arn
}

resource "aws_iam_group_policy_attachment" "client_admin_mfa" {
  group      = aws_iam_group.client_admin.name
  policy_arn = aws_iam_policy.mfa_policy.arn
}

resource "aws_iam_user" "silicon" {
  count = length(var.silicon_names)
  name  = var.silicon_names[count.index]
  path  = "/"
}

resource "aws_iam_user" "client" {
  count = length(var.client_names)
  name  = var.client_names[count.index]
  path  = "/"
}

resource "aws_iam_group_membership" "silicon_admin" {
  name  = "silicon-admin-group-membership"
  users = var.silicon_names
  group = aws_iam_group.silicon_admin.name
}

resource "aws_iam_group_membership" "client_admin" {
  name  = "client-admin-group-membership"
  users = var.client_names
  group = aws_iam_group.client_admin.name
}
