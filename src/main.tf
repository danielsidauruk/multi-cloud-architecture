
module "aws_network" {
  source = "./aws/modules/network"

  region     = var.aws_region
  az_count   = var.az_count
  cidr_block = cidrsubnet(var.cidr_block, 1, 0)

}
