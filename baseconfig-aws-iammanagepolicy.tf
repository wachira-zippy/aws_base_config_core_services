data "aws_iam_policy_document" "manage_own" {

  statement {
    sid    = "AllowViewAccountInfo"
    effect = "Allow"
    actions = ["iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListUsers",
    "iam:ListVirtualMFADevices"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowManageOwnPasswords"
    effect = "Allow"
    actions = ["iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:UpdateLoginProfile",
      "iam:ChangePassword",
    "iam:GetUser"]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "AllowManageOwnAccessKeys"
    effect = "Allow"
    actions = ["iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
    "iam:UpdateAccessKey"]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "AllowManageOwnSigningCertificates"
    effect = "Allow"
    actions = ["iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
    "iam:UploadSigningCertificate"]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "AllowManageOwnSSHPublicKeys"
    effect = "Allow"
    actions = ["iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
    "iam:UploadSSHPublicKey"]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "AllowManageOwnGitCredentials"
    effect = "Allow"
    actions = ["iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
    "iam:UpdateServiceSpecificCredential"]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "AllowManageOwnVirtualMFADevice"
    effect = "Allow"
    actions = ["iam:CreateVirtualMFADevice",
    "iam:DeleteVirtualMFADevice"]
    resources = ["arn:aws:iam::*:mfa/$${aws:username}"]
  }

  statement {
    sid    = "AllowManageOwnUserMFA"
    effect = "Allow"
    actions = ["iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
    "iam:ResyncMFADevice"]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"
    not_actions = ["iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "iam:ListUsers",
      "iam:CreateLoginProfile",
      "iam:ChangePassword",
    "sts:GetSessionToken"]
    resources = ["*"]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values = ["false"
      ]
    }
  }
}
