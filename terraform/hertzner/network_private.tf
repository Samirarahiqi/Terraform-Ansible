resource "hcloud_network" "privNet" {
  name     = "terraform-net"
  ip_range = "172.16.100.0/24"
}

resource "hcloud_network_subnet" "network-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.privNet.id
  network_zone = "eu-central"
  ip_range     = "172.16.100.0/28"
}
