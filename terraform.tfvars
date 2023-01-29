matchbox_http_endpoint = "http://matchbox.tosuke.internal:8080"
matchbox_rpc_endpoint = "nono:8081"
os_version = "37.20221127.3.0"
# os_version = "36.20220906.3.2"
password_hash = "$y$j9T$CEreOLo74cJcogiN/1CBe0$yTjA9PSQPhdN0d8SB4O8fW2173aHgS9wVdK3rUhYAID"
ssh_authorized_key = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIH7Xo5JiR3JlbOXR92t4ge40/ik9IEhTbeoMvaI98VzbAAAABHNzaDo="

nodes = {
    hayama = {
        name = "hayama"
        arch = "aarch64"
        mac = "dc:a6:32:72:85:8d"
        role = "controller"

        asn = 65001
        primary_ipv4 = "192.168.3.1"
        primary_ipv6 = "240d:1a:d4e:c503::1"

        eth0_ipv4 = "192.168.20.2"
        eth0_ipv6 = "fe80::2"
    },
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