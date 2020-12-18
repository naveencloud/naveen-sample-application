
resource "aws_security_group_rule" "ec2_sgr_ing_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.naveen_application_server.ec2_sg
}

resource "aws_security_group_rule" "ec2_sgr_ing_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.naveen_application_server.ec2_sg
}