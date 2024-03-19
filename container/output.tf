# output "ip_address" {
#   value       = [for i in docker_container.nodered_container[*] : join(":", [i.network_data[0]["ip_address"], i.ports[0]["external"]])] 
#   description = "The IP address and external ports of the container"
  
# }

# output "container-name" {
#   value       = docker_container.nodered_container.name
#   description = "The name of the container"
# }