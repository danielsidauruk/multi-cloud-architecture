resource "aws_security_group" "vm_firewall" {
  name        = "vm-firewall"
  description = "Security group for client VM"
  vpc_id      = var.vpc_id

  tags = {
    Name = "vm-firewall"
  }
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  security_group_id = aws_security_group.vm_firewall.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_egress" {
  security_group_id = aws_security_group.vm_firewall.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_icmp" {
  security_group_id = aws_security_group.vm_firewall.id
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.cidr_block]
  type              = "ingress"
}