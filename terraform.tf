terraform {
  required_providers {
    ct = {
        source = "poseidon/ct"
        version = "0.11.0"
    }
    matchbox = {
        source = "poseidon/matchbox"
        version = "0.5.2"
    }
  }
}

provider "matchbox" {
  endpoint = var.matchbox_rpc_endpoint
  ca = file("./.matchbox/ca.crt")
  client_cert = file("./.matchbox/client.crt")
  client_key = file("./.matchbox/client.key")
}