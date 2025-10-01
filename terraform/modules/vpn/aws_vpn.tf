
locals {
  gcp_vpn_interface_ips = [
    for interface in google_compute_ha_vpn_gateway.gcp_vpn_gateway.vpn_interfaces :
    interface.ip_address
  ]
}

# GCP Gateway
resource "aws_customer_gateway" "gcp_vpn_gateway" {
  count = 2

  bgp_asn    = var.gcp_asn
  ip_address = local.gcp_vpn_interface_ips[count.index]
  type       = "ipsec.1"

  tags = {
    Name = "Customer Gateway ${count.index} (GCP HA VPN)"
  }
}

# VPN Gateway & Connection
resource "aws_vpn_gateway" "aws_vpn_gateway" {
  vpc_id          = var.aws_vpc_id
  amazon_side_asn = var.aws_asn # 65001

  tags = {
    Name = "AWS VPN Gateway"
  }
}

resource "aws_vpn_connection" "aws_to_gcp_vpn" {
  count = 2

  vpn_gateway_id      = aws_vpn_gateway.aws_vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.gcp_vpn_gateway[count.index].id
  type                = "ipsec.1"
  static_routes_only  = false

  tags = {
    Name = "AWS VPN Connection ${count.index}"
  }
}
