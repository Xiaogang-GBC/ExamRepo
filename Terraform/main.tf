terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_network" "app_network" {
  name = "app_network"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-container"
  
  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["web"]
  }

  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = abspath("${path.module}/html")
    read_only      = false
  }

  env = [
    "MY_ENV_VAR=myvalue"
  ]
}
