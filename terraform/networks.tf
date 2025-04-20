resource "yandex_vpc_network" "terraform-network" {
  name = "terraform-network"
}

resource "yandex_vpc_subnet" "subnet-private" {
  name           = "subnet_private"
  zone           = var.vm.private.zone
  network_id     = yandex_vpc_network.terraform-network.id
  v4_cidr_blocks = var.vm.private.network_cidr
}
