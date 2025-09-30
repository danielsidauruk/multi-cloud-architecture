
resource "google_compute_ha_vpn_gateway" "gcp" {
  name    = "ha-vpn-gateway"
  network = var.gcp_vpc_self_link
  region  = var.gcp_region
}

resource "google_compute_router" "gcp" {
  name    = "cloud-router"
  network = google_compute_ha_vpn_gateway.gcp.network
  region  = google_compute_ha_vpn_gateway.gcp.region
  bgp {
    asn            = var.gcp_asn # 65000
    advertise_mode = "DEFAULT"
  }
}

locals {
  tunnels = flatten([
    for k, v in aws_vpn_connection.aws_to_gcp : [
      {
        # tunnel1
        tunnel = {
          address            = v.tunnel1_address
          cgw_inside_address = v.tunnel1_cgw_inside_address
          vgw_inside_address = v.tunnel1_vgw_inside_address
          preshared_key      = nonsensitive(v.tunnel1_preshared_key)
        }
      },
      {
        # tunnel2
        tunnel = {
          address            = v.tunnel2_address
          cgw_inside_address = v.tunnel2_cgw_inside_address
          vgw_inside_address = v.tunnel2_vgw_inside_address
          preshared_key      = nonsensitive(v.tunnel2_preshared_key)
        }
      }
    ]
  ])

  aws_vpn_connections = {
    for i, t in local.tunnels : i => {
      tunnel_address                  = t.tunnel.address
      peer_external_gateway_interface = i
      vpn_gateway_interface           = floor(i / 2)
      preshared_key                   = t.tunnel.preshared_key
      vgw_inside_address              = t.tunnel.vgw_inside_address
      cgw_inside_address              = t.tunnel.cgw_inside_address
    }
  }
}


# AWS Gateway & Connection
resource "google_compute_external_vpn_gateway" "aws_gateway" {
  name            = "aws-vpn-gateway"
  redundancy_type = "FOUR_IPS_REDUNDANCY"

  dynamic "interface" {
    for_each = local.aws_vpn_connections

    content {
      id         = interface.value.peer_external_gateway_interface
      ip_address = interface.value.tunnel_address
    }
  }
}

resource "google_compute_vpn_tunnel" "tunnels" {
  # equal to aws_vpn_connection
  for_each = local.aws_vpn_connections

  name                            = "gcp-to-aws-tunnel-${each.key}"
  shared_secret                   = each.value.preshared_key # example: "NMjW1yw.xxxxxxxxxxxdfE0"
  ike_version                     = 2
  router                          = google_compute_router.gcp.name
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp.self_link
  vpn_gateway_interface           = each.value.vpn_gateway_interface # 0 - 1
  peer_external_gateway           = google_compute_external_vpn_gateway.aws_gateway.self_link
  peer_external_gateway_interface = each.value.peer_external_gateway_interface # 0 - 3

}

resource "google_compute_router_interface" "router_interfaces" {
  for_each = local.aws_vpn_connections

  name       = "if-bgp-session-${each.key}"
  router     = google_compute_router.gcp.name
  vpn_tunnel = google_compute_vpn_tunnel.tunnels[each.key].self_link
}

resource "google_compute_router_peer" "router_peers" {
  for_each = local.aws_vpn_connections

  name            = "bgp-session-${each.key}"
  router          = google_compute_router.gcp.name
  interface       = google_compute_router_interface.router_interfaces[each.key].name
  peer_asn        = var.aws_asn
  ip_address      = each.value.cgw_inside_address
  peer_ip_address = each.value.vgw_inside_address
}
