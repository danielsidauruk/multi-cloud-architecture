
module "aws_network" {
  source = "./modules/aws/network"

  region          = var.aws_region
  az_count        = var.az_count
  cidr_block      = cidrsubnet(var.cidr_block, 1, 0)
  aws_vpn_gateway = module.vpn.vgw_id
}


module "gcp_network" {
  source = "./modules/gcp/network"

  vpc_name   = var.vpc_name
  region     = var.gcp_region
  az_count   = var.az_count
  cidr_block = cidrsubnet(var.cidr_block, 1, 1)
}


module "vpn" {
  source = "./modules/vpn"

  gcp_region = var.gcp_region
  gcp_asn    = var.gcp_asn
  aws_asn    = var.aws_asn

  gcp_vpc_self_link = module.gcp_network.vpc_self_link
  aws_vpc_id        = module.aws_network.vpc_id
}