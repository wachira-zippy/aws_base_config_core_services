resource "aws_backup_vault" "backup_vault" {
  name        = "companyname-environment_backup_vault"
  kms_key_arn = data.aws_kms_key.backup.arn
  tags = {
    Name = "companyname-environment-backup-vault"
  }
}

resource "aws_backup_plan" "daily_backup_plan" {
  name = "companyname-environment_daily_backup_plan"

  rule {
    rule_name                = "daily_backup_rule"
    target_vault_name        = aws_backup_vault.backup_vault.name
    schedule                 = "cron(0 1 * * ? *)"
    start_window             = "60"
    completion_window        = "120"
    enable_continuous_backup = false

    recovery_point_tags = {
      Name = "companyname-environment_backups"
    }

    lifecycle {
      cold_storage_after = 0
      delete_after       = 14
    }
  }
}

resource "aws_backup_selection" "daily_backups" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "companyname-environment_backups"
  plan_id      = aws_backup_plan.daily_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "env"
    value = "backup"
  }
}

resource "aws_backup_plan" "weekly_backup_plan" {
  name = "companyname-environment_weekly_backup_plan"

  rule {
    rule_name                = "weekly_backup_rule"
    target_vault_name        = aws_backup_vault.backup_vault.name
    schedule                 = "cron(0 2 ? * 6 *)"
    start_window             = "60"
    completion_window        = "120"
    enable_continuous_backup = false

    recovery_point_tags = {
      Name = "companyname-environment_backups"
    }

    lifecycle {
      cold_storage_after = 0
      delete_after       = 120
    }
  }
}

resource "aws_backup_selection" "weekly_backups" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "companyname-environment_backups"
  plan_id      = aws_backup_plan.weekly_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "env"
    value = "backup"
  }
}

resource "aws_backup_plan" "monthly_backup_plan" {
  name = "companyname-environment_monthly_backup_plan"

  rule {
    rule_name                = "monthly_backup_rule"
    target_vault_name        = aws_backup_vault.backup_vault.name
    schedule                 = "cron(0 3 1 * ? *)"
    start_window             = "60"
    completion_window        = "120"
    enable_continuous_backup = false

    recovery_point_tags = {
      Name = "companyname-environment_backups"
    }

    lifecycle {
      cold_storage_after = 0
      delete_after       = 420
    }
  }
}

resource "aws_backup_selection" "monthly_backups" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "companyname-environment_backups"
  plan_id      = aws_backup_plan.monthly_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "env"
    value = "backup"
  }
}

resource "aws_iam_role" "backup" {
  name               = "aws-backup-policy"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws-backup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup.name
}
