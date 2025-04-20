resource "yandex_iam_service_account" "sa" {
  name = var.sa_name
}

resource "yandex_compute_instance_group" "lamp_group" {
  name = var.vm.private.groupname
  service_account_id = yandex_iam_service_account.sa.id
  instance_template {
    resources {
      cores  = 2
      memory = 1
      core_fraction = 5
    }

    boot_disk {
      initialize_params {
        image_id = var.vm.private.image
        size = var.vm.private.boot_disk_size
      }
    }

    scheduling_policy {
      preemptible = var.vm.private.preemptible
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnet-private.id]
      nat = var.vm.private.nat
    }

    metadata = {
      user-data = "${file("cloud_conf.yaml")}"
    }
  }
  scale_policy {
    fixed_scale {
      size = var.lamp.private.size
    }
  }

  deploy_policy {
    max_unavailable = var.lamp.private.max_unavailable
    max_expansion   = var.lamp.private.max_expansion
  }

  health_check {
    interval = var.lamp.private.interval
    timeout  = var.lamp.private.timeout
    healthy_threshold   = var.lamp.private.healthy_threshold
    unhealthy_threshold = var.lamp.private.unhealthy_threshold
    tcp_options {
      port = var.lamp.private.port
    }
  }

  allocation_policy {
    zones = [var.vm.private.zone]
  }

  load_balancer {
        target_group_name = var.vm.private.groupname
  }
}