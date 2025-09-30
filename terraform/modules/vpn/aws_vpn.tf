
locals {
  gcp_vpn_interface_ips = {
    for interface in google_compute_ha_vpn_gateway.gcp.vpn_interfaces :
    interface.id => interface.ip_address
  }
}

# Customer Gateway for GCP
resource "aws_customer_gateway" "gcp" {
  for_each = local.gcp_vpn_interface_ips

  bgp_asn    = var.gcp_asn
  ip_address = each.value
  type       = "ipsec.1"

  depends_on = [google_compute_ha_vpn_gateway.gcp]

  tags = {
    Name = "Customer Gateway ${each.key} (GCP HA VPN)"
  }
}


# VPN Gateway & Connection
resource "aws_vpn_gateway" "aws" {
  vpc_id          = var.aws_vpc_id
  amazon_side_asn = var.aws_asn # 65001

  tags = {
    Name = "AWS VPN Gateway"
  }
}

resource "aws_vpn_connection" "aws_to_gcp" {
  for_each = aws_customer_gateway.gcp

  vpn_gateway_id      = aws_vpn_gateway.aws.id
  customer_gateway_id = each.value.id
  type                = "ipsec.1"
  static_routes_only  = false

  tags = {
    Name = "AWS VPN Connection ${each.key}"
  }
}
