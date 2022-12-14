resource "matchbox_profile" "nodes" {
  for_each = var.nodes
  name = each.key

  kernel = "/assets/fedora-coreos/fedora-coreos-${var.os_version}-live-kernel-${each.value.arch}"
  initrd = [
    "--name main /assets/fedora-coreos/fedora-coreos-${var.os_version}-live-initramfs.${each.value.arch}.img",
  ]

  args = [
    "initrd=main",
    "coreos.live.rootfs_url=${var.matchbox_http_endpoint}/assets/fedora-coreos/fedora-coreos-${var.os_version}-live-rootfs.${each.value.arch}.img",
    "ignition.firstboot",
    "ignition.platform.id=metal",
    "ignition.config.url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
  ]

  raw_ignition = data.ct_config.nodes[each.key].rendered
}