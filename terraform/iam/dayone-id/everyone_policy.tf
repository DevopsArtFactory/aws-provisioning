#### Permission to rotate key
resource "aws_iam_policy" "RotateKeys" {
  name        = "RotateKeys"
  description = "allow users to change their aws keys, and passwords."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:*LoginProfile",
                "iam:*AccessKey*",
                "iam:*SSHPublicKey*"
            ],
            "Resource": "arn:aws:iam::${var.account_id}:user/$${aws:username}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:ListAccount*",
                "iam:GetAccountSummary",
                "iam:GetAccountPasswordPolicy",
                "iam:ListUsers"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#### Permission to self managed MFA
resource "aws_iam_policy" "SelfManageMFA" {
  name        = "SelfManageMFA"
  description = "allow a user to manage their own MFA device."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowUsersToCreateDeleteTheirOwnVirtualMFADevices",
            "Effect": "Allow",
            "Action": [
                "iam:*VirtualMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::${var.account_id}:mfa/$${aws:username}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "iam:GetAccountPasswordPolicy",
            "Resource": "*"
        },
        {
            "Sid": "AllowUsersToManageTheirOwnPassword",
            "Effect": "Allow",
            "Action": [
                "iam:ChangePassword"
            ],
            "Resource": [
                "arn:aws:iam::${var.account_id}:user/$${aws:username}"
            ]
        },
        {
            "Sid": "AllowUsersToEnableSyncDisableTheirOwnMFADevices",
            "Effect": "Allow",
            "Action": [
                "iam:DeactivateMFADevice",
                "iam:EnableMFADevice",
                "iam:ListMFADevices",
                "iam:ResyncMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::${var.account_id}:user/$${aws:username}"
            ]
        },
        {
            "Sid": "AllowUsersToListVirtualMFADevices",
            "Effect": "Allow",
            "Action": [
                "iam:ListVirtualMFADevices"
            ],
            "Resource": [
                "arn:aws:iam::${var.account_id}:mfa/*"
            ]
        },
        {
            "Sid": "AllowUsersToListUsersInConsole",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers"
            ],
            "Resource": [
                "arn:aws:iam::${var.account_id}:user/*"
            ]
        }
    ]
}
EOF
}

#### Force user to use MFA for security issue
resource "aws_iam_policy" "ForceMFA" {
  name        = "ForceMFA"
  description = "disallow a user anything unless MFA enabled"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DoNotAllowAnythingOtherThanAboveUnlessMFAd",
            "Effect": "Deny",
            "NotAction": [
                "iam:*",
                "sts:AssumeRole",
                "s3:*",
                "dynamodb:*",
                "*"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:MultiFactorAuthAge": "true"
                }
            }
        }
    ]
}
EOF
}



