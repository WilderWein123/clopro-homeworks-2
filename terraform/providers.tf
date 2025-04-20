terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token                    = var.token
  cloud_id                 = var.cloud.netology.cloud_id
  folder_id                = var.cloud.netology.folder_id
  zone                     = var.cloud.netology.default_zone
}