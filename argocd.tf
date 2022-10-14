data "kustomization_build" "argocd" {
  path = "${path.module}/manifests/argocd/overlays/istio"
}

resource "kustomization_resource" "argocd_p0" {
  for_each = data.kustomization_build.argocd.ids_prio[0]

  manifest = (
    contains(["_/Secret"], regex("(?P<group_kind>.*/.*)/.*/.*", each.value)["group_kind"])
    ? sensitive(data.kustomization_build.argocd.manifests[each.value])
    : data.kustomization_build.argocd.manifests[each.value]
  )
}

resource "kustomization_resource" "argocd_p1" {
  for_each = data.kustomization_build.argocd.ids_prio[1]

  manifest = (
    contains(["_/Secret"], regex("(?P<group_kind>.*/.*)/.*/.*", each.value)["group_kind"])
    ? sensitive(data.kustomization_build.argocd.manifests[each.value])
    : data.kustomization_build.argocd.manifests[each.value]
  )

  depends_on = [kustomization_resource.argocd_p0]
}

resource "kustomization_resource" "argocd_p2" {
  for_each = data.kustomization_build.argocd.ids_prio[2]

  manifest = (
    contains(["_/Secret"], regex("(?P<group_kind>.*/.*)/.*/.*", each.value)["group_kind"])
    ? sensitive(data.kustomization_build.argocd.manifests[each.value])
    : data.kustomization_build.argocd.manifests[each.value]
  )

  depends_on = [kustomization_resource.argocd_p1]
}