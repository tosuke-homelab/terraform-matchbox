locals {
  nil_config = "variant: fcos\nversion: 1.4.0\n"
  kubeadm = {
    "x86_64" = {
      source = "https://dl.k8s.io/release/${local.kubernetes.version}/bin/linux/amd64/kubeadm"
    }
    "aarch64" = {
      source = "https://dl.k8s.io/release/${local.kubernetes.version}/bin/linux/arm64/kubeadm"
    }
  }
  crictl = {
    "x86_64" = {
      source = "https://github.com/kubernetes-sigs/cri-tools/releases/download/${local.kubernetes.crictl_version}/crictl-${local.kubernetes.crictl_version}-linux-amd64.tar.gz"
    }
    "aarch64" = {
      source = "https://github.com/kubernetes-sigs/cri-tools/releases/download/${local.kubernetes.crictl_version}/crictl-${local.kubernetes.crictl_version}-linux-arm64.tar.gz"
    }
  }
}

data "ct_config" "nodes" {
  for_each = local.nodes
  content  = file("${path.module}/butane/${each.key}.yaml")
  strict   = true

  snippets = [
    templatefile("${path.module}/butane/snnipets/node.yaml", {
      password_hash      = local.fcos.password_hash
      ssh_authorized_key = local.fcos.ssh_authorized_key,
      kubeadm_source     = local.kubeadm[each.value.arch].source,
      crictl_source      = local.crictl[each.value.arch].source,
      kubernetes_version = local.kubernetes.version,
    }),
    templatefile("${path.module}/butane/snnipets/network.yaml", {
      primary_ipv4 = each.value.primary_ipv4,
      primary_ipv6 = each.value.primary_ipv6,

      dns = "192.168.20.100 192.168.20.101", # FIXME: correct DNS server

      eth0_mac  = each.value.mac,
      eth0_ipv4 = each.value.eth0_ipv4,
      eth0_ipv6 = each.value.eth0_ipv6,

      bird_image_url = "${local.matchbox.http_endpoint}/assets/bird/bird-${each.value.arch}.tar.gz",
      bird_image     = "ghcr.io/tosuke-homelab/bird:2.0-${each.value.arch}",

      local_asn = each.value.asn,

      peers = [
        {
          asn          = 65100,
          address      = "192.168.20.100",
          nexthop_ipv6 = each.value.eth0_ipv6,
        },
        {
          asn          = 65100,
          address      = "192.168.20.101",
          nexthop_ipv6 = each.value.eth0_ipv6,
        },
      ],
    }),
    each.value.role == "controller" ? templatefile("${path.module}/butane/snnipets/controller.yaml", {
      primary_ipv4 = each.value.primary_ipv4,
    }) : local.nil_config,
    each.value.role == "worker" ? templatefile("${path.module}/butane/snnipets/worker.yaml", {
      primary_ipv4 = each.value.primary_ipv4,
    }) : local.nil_config,
  ]
}