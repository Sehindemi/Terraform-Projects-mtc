terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.image_id
  ports {
    internal = 1880
    external = 1880
  }
}

output "IP-Address" {
  value = join(":", [docker_container.nodered_container.network_data[0].ip_address, docker_container.nodered_container.ports[0].external])
  description = "The IP address and external ports of the container"
}

output "container-name" {
  value = docker_container.nodered_container.name
  description = "The name of the container"
}