#### Permission to rotate key
resource "aws_iam_policy" "rotate_keys" {
  name        = "RotateKeys"
  description = "allow users to change their aws keys, and passwords."

  policy = data.aws_iam_policy_document.rotate_keys.json
}

data "aws_iam_policy_document" "rotate_keys" {
  statement {
    actions = [
      "iam:*LoginProfile",
      "iam:*AccessKey*",
      "iam:*SSHPublicKey*"
    ]
    resources = ["arn:aws:iam::${var.account_id.id}:user/$${aws:username}"]
  }

  statement {
    actions = [
      "iam:ListAccount*",
      "iam:GetAccountSummary",
      "iam:GetAccountPasswordPolicy",
      "iam:ListUsers"
    ]
    resources = ["*"]
  }
}

#### Permission to self managed MFA
resource "aws_iam_policy" "self_managed_mfa" {
  name        = "SelfManageMFA"
  description = "allow a user to manage their own MFA device."

  policy = data.aws_iam_policy_document.self_managed_mfa.json
}

data "aws_iam_policy_document" "self_managed_mfa" {
  statement {
    actions = [
      "iam:*VirtualMFADevice"
    ]
    resources = ["arn:aws:iam::${var.account_id.id}:mfa/$${aws:username}"]
  }

  statement {
    actions = [
      "iam:GetAccountPasswordPolicy"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "iam:ChangePassword"
    ]
    resources = ["arn:aws:iam::${var.account_id.id}:user/$${aws:username}"]
  }

  statement {
    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]
    resources = ["arn:aws:iam::${var.account_id.id}:user/$${aws:username}"]
  }

  statement {
    actions = [
      "iam:ListVirtualMFADevices"
    ]
    resources = ["arn:aws:iam::${var.account_id.id}:mfa/*"]
  }

  statement {
    actions = [
      "iam:ListUsers"
    ]
    resources = ["arn:aws:iam::${var.account_id.id}:user/*"]
  }
}