resource "aws_iam_role" "this" {
  name = "${var.project_key}-${var.role_name}"

  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "this" {
  name        = "${var.project_key}-${var.policy_name}"
  description = "IAM Policy for ${var.project_key}"

  policy = var.policy_json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_group" "this" {
  count = var.create_group ? 1 : 0
  name  = "${var.project_key}-${var.group_name}"
}

resource "aws_iam_group_policy_attachment" "group_attach" {
  count      = var.create_group ? 1 : 0
  group      = aws_iam_group.this[0].name
  policy_arn = aws_iam_policy.this.arn
}
