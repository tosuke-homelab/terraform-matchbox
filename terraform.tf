terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "0.11.0"
    }
    matchbox = {
      source  = "poseidon/matchbox"
      version = "0.5.2"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "tosuke-homelab"

    workspaces {
      name = "terraform-matchbox"
    }
  }
}

provider "matchbox" {
  endpoint    = local.matchbox.rpc_endpoint
  ca          = local.matchbox.ca_cert
  client_cert = local.matchbox.client_cert
  client_key  = local.matchbox.client_key
}