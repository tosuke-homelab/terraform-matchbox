resource "matchbox_profile" "nodes" {
  for_each = local.nodes
  name     = each.key

  kernel = "/assets/fedora-coreos/fedora-coreos-${local.fcos.version}-live-kernel-${each.value.arch}"
  initrd = [
    "--name main /assets/fedora-coreos/fedora-coreos-${local.fcos.version}-live-initramfs.${each.value.arch}.img",
  ]

  args = [
    "initrd=main",
    "coreos.live.rootfs_url=${local.matchbox.http_endpoint}/assets/fedora-coreos/fedora-coreos-${local.fcos.version}-live-rootfs.${each.value.arch}.img",
    "ignition.firstboot",
    "ignition.platform.id=metal",
    "ignition.config.url=${local.matchbox.http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
  ]

  raw_ignition = data.ct_config.nodes[each.key].rendered
}