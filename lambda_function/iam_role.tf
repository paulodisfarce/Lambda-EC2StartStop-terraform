resource "aws_iam_role" "ec2_management_role" {
  name = "EC2ManagementRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_management_policy" {
  name        = "EC2ManagementPolicy"
  description = "Allows starting/stopping EC2 instances"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:Start*",
          "ec2:Stop*"
        ],
        "Resource" : "*"
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "ec2_management_policy_attachment" {
  role       = aws_iam_role.ec2_management_role.name
  policy_arn = aws_iam_policy.ec2_management_policy.arn
}