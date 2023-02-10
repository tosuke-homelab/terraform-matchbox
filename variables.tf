variable "MATCHBOX_RPC_ENDPOINT" {
  type        = string
  description = "Matchbox RPC endpoint"
}

variable "MATCHBOX_CA_CERT" {
  type        = string
  description = "Base64-encoded Matchbox CA certificate"
}

variable "MATCHBOX_CLIENT_CERT" {
  type        = string
  description = "Base64-encoded Matchbox client certificate"
}

variable "MATCHBOX_CLIENT_KEY" {
  type        = string
  description = "Base64-encoded Matchbox client key"
}

variable "PASSWORD_HASH" {
  type        = string
  description = "Password hash"
}

variable "SSH_AUTHORIZED_KEY" {
  type        = string
  description = "SSH Public key"
}

locals {
  matchbox = {
    http_endpoint = "http://matchbox.tosuke.internal:8080"
    rpc_endpoint  = var.MATCHBOX_RPC_ENDPOINT
    ca_cert       = base64decode(var.MATCHBOX_CA_CERT)
    client_cert   = base64decode(var.MATCHBOX_CLIENT_CERT)
    client_key    = base64decode(var.MATCHBOX_CLIENT_KEY)
  }
  fcos = {
    version            = "37.20221127.3.0"
    password_hash      = var.PASSWORD_HASH
    ssh_authorized_key = var.SSH_AUTHORIZED_KEY
  }
  kubernetes = {
    version = "v1.26.1"
  }
  nodes = {
    hayama = {
      name = "hayama"
      arch = "aarch64"
      mac  = "dc:a6:32:72:85:8d"
      role = "controller"

      asn          = 65001
      primary_ipv4 = "192.168.3.1"
      primary_ipv6 = "2400:8902:e002:5603::1:0"

      eth0_ipv4 = "192.168.20.1"
      eth0_ipv6 = "fe80::1"
    },
    kodaka = {
      name = "kodaka"
      arch = "x86_64"
      mac  = "b4:2e:99:60:dd:51"
      role = "worker"

      asn          = 65002
      primary_ipv4 = "192.168.3.2"
      primary_ipv6 = "2400:8902:e002:5603::2:0"

      eth0_ipv4 = "192.168.20.2"
      eth0_ipv6 = "fe80::2"
    }
  }
}