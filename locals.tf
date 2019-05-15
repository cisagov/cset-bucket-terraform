locals {
  # This is a goofy but necessary way to determine if
  # terraform.workspace contains the substring "prod"
  production_workspace = "${replace(terraform.workspace, "prod", "") != terraform.workspace}"

  # the bucket name, e.g., ncats-cset-binaries-production, or ncats-cset-binaries-felddy
  cset_bucket_name = "${local.production_workspace ? format("%s-production", var.cset_s3_bucket_name) : format("%s-%s", var.cset_s3_bucket_name, terraform.workspace)}"

  # calculate a subdomain when in non-production, e.g., cset.felddy.cyber.dhs.gov
  inserted_subdomain = "${local.production_workspace ? "" : format(".%s", terraform.workspace)}"

  # put it all together
  distribution_domain_final = "${format("%s%s.%s",
    var.distribution_sub_domain,
    local.inserted_subdomain,
    var.distribution_root_domain
  )}"
}
