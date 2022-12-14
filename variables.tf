variable "matchbox_http_endpoint" {
  type = string
  description = "Matchbox HTTP endpoint"
}

variable "matchbox_rpc_endpoint" {
  type = string
  description = "Matchbox gRPC endpoint"
}

variable "os_version" {
  type = string
  description = "Fedora CoreOS version"
}

variable "password_hash" {
  type = string
  description = "Password hash"
}

variable "ssh_authorized_key" {
  type = string
  description = "SSH Public key"
}

variable "peers" {
  type = list(object({
    asn = number
    ipv4 = string
  }))
  description = "List of peers"
}

variable "nodes" {
  type = map(object({
    arch = string
    mac = string
    role = string

    asn = number
    primary_ipv4 = string
    primary_ipv6 = string

    eth0_ipv4 = string
    eth0_ipv6 = string
  }))
  description = "List of nodes"
}