matchbox_http_endpoint = "http://matchbox.tosuke.internal:8080"
matchbox_rpc_endpoint = "192.168.1.5:8081"
os_version = "37.20221106.3.0"
# os_version = "36.20220906.3.2"
password_hash = "$y$j9T$orJi/CcCxSzOVMBpL4/7X.$38t0aPhIHzOnXPCQJyAQ.iOyRg/hUh/YQE9kUnx3SZ."
ssh_authorized_key = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIH7Xo5JiR3JlbOXR92t4ge40/ik9IEhTbeoMvaI98VzbAAAABHNzaDo="

nodes = {
    kodaka = {
        name = "kodaka"
        arch = "x86_64"
        mac = "b4:2e:99:60:dd:51"
        role = "worker"

        asn = 65002
        primary_ipv4 = "192.168.3.2"
        primary_ipv6 = "240d:1a:d4e:c503::2"

        eth0_ipv4 = "192.168.20.3"
        eth0_ipv6 = "fe80::3"
    }
}