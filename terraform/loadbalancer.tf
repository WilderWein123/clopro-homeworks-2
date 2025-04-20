resource "yandex_lb_network_load_balancer" "balancer" {
  name        = var.balancer.private.name
  folder_id   = var.cloud.netology.folder_id
  listener {
    name = var.balancer.private.listener_name
    port = var.balancer.private.listener_port
    external_address_spec {
      ip_version = "ipv4"
    }
  }

attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_group.load_balancer.0.target_group_id
    healthcheck {
      name = var.balancer.private.listener_name
      interval = var.lamp.private.interval
      timeout = var.lamp.private.timeout
      unhealthy_threshold = var.lamp.private.unhealthy_threshold
      healthy_threshold = var.lamp.private.healthy_threshold
      http_options {
        port = var.lamp.private.port
        path = "/"
      }
    }
  }
}