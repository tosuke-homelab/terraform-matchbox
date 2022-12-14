data "ct_config" "nodes" {
  for_each = var.nodes
  content = file("${path.module}/butane/${each.key}.yaml")
  strict = true

  snippets = [
    templatefile("${path.module}/butane/snnipets/node.yaml", {
      ssh_authorized_key = var.ssh_authorized_key,
      password_hash = var.password_hash
    }),
    templatefile("${path.module}/butane/snnipets/network.yaml", {
      primary_ipv4 = each.value.primary_ipv4,
      primary_ipv6 = each.value.primary_ipv6,

      dns = "192.168.20.1", # FIXME: correct DNS server

      eth0_mac = each.value.mac,
      eth0_ipv4 = each.value.eth0_ipv4,
      eth0_ipv6 = each.value.eth0_ipv6,

      bird_img = "${var.matchbox_http_endpoint}/assets/bird/bird-${each.value.arch}.tar.gz",

      local_asn = each.value.asn,
      peer1 = "192.168.20.100",
      peer1_asn = 65100,
      peer1_nexthop_ipv6 = each.value.eth0_ipv6,
      peer2 = "192.168.20.101",
      peer2_asn = 65100,
      peer2_nexthop_ipv6 = each.value.eth0_ipv6,
    }),
  ]
}