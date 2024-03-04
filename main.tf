terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

variable "ext_port" {
  type    = number
  default = 1880
}

variable "int_port" {
  type    = number
  default = 1880
}

variable "container_count" {
  type    = number
  default = 2
}
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}
resource "random_string" "random" {
  count   = var.container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "nodered_container" {
  count = var.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = var.int_port
    external = var.ext_port
  }
}


output "ip_address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.network_data[0]["ip_address"], i.ports[0]["external"]])]
  description = "The IP address and external ports of the container"
}

output "container-name" {
  value       = docker_container.nodered_container[*].name
  description = "The name of the container"
}

