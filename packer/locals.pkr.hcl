locals {
  now            = timestamp()
  first_of_month = formatdate("YYYY.MM.01", local.now)
  iso_mirror     = "https://mirrors.edge.kernel.org"
}
