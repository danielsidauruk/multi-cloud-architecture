
# AWS <=> GCP
module "vpn" {
  source = "./modules/vpn"

  gcp_region = var.gcp_region
  gcp_asn    = var.gcp_asn
  aws_asn    = var.aws_asn

  gcp_vpc_self_link = module.gcp_network.vpc_self_link
  aws_vpc_id        = module.aws_network.vpc_id
}

# AWS 
module "aws_network" {
  source = "./modules/aws/network"

  region     = var.aws_region
  az_count   = var.az_count
  cidr_block = cidrsubnet(var.cidr_block, 1, 0)
  vgw_id     = module.vpn.vgw_id
}

module "aws_vm" {
  source = "./modules/aws/vm"

  key_name   = var.key_name
  cidr_block = var.cidr_block

  vpc_id            = module.aws_network.vpc_id
  public_subnet_ids = module.aws_network.public_subnet_ids
}

module "aws_database" {
  source = "./modules/aws/database"

  cidr_block           = var.cidr_block
  db_name              = var.db_name
  db_username          = var.db_username
  db_username_password = var.db_username_password

  vpc_id             = module.aws_network.vpc_id
  private_subnet_ids = module.aws_network.private_subnet_ids
}

# GCP
module "google_services" {
  source = "./modules/gcp/google-services"
}

module "gcp_network" {
  source = "./modules/gcp/network"

  vpc_name     = var.vpc_name
  region       = var.gcp_region
  subnet_count = var.subnet_count
  cidr_block   = cidrsubnet(var.cidr_block, 1, 1)

  depends_on = [module.google_services]
}

module "gcp_vm" {
  source = "./modules/gcp/vm"

  region     = var.gcp_region
  project_id = var.gcp_project_id
  cidr_block = var.cidr_block

  vpc_name          = module.gcp_network.vpc_name
  public_subnet_ids = module.gcp_network.public_subnet_ids

  depends_on = [module.google_services]
}

module "gcp_database" {
  source = "./modules/gcp/database"

  project_id                = var.gcp_project_id
  region                    = var.gcp_region
  db_name                   = var.db_name
  replication_user          = var.replication_user
  replication_user_password = var.replication_user_password
  root_password             = var.root_password

  rds_instance_address = module.aws_database.db_instance_address
  vpc_self_link        = module.gcp_network.vpc_self_link

  depends_on = [
    module.google_services,
    module.gcp_network
  ]
}
