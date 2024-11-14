output "flask_service_url" {
  description = "The URL for the Flask service"
  value       = aws_lb.flask_lb.dns_name
}

output "ollama_service_url" {
  description = "The URL for the Ollama service"
  value       = aws_lb.ollama_lb.dns_name
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.cluster.name
}

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = aws_subnet.main.id
}
