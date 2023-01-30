resource "matchbox_group" "nodes" {
  for_each = local.nodes
  name     = each.key
  profile  = matchbox_profile.nodes[each.key].name

  selector = {
    "mac" = each.value.mac
  }
}