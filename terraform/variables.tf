variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"  # Change as needed
}

variable "flask_image" {
  description = "Docker image for the Flask application"
  type        = string
  default     = "your-docker-repo/flask-api:latest"
}

variable "ollama_image" {
  description = "Docker image for the Ollama API"
  type        = string
  default     = "your-docker-repo/ollama-api:latest"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ecs_task_memory" {
  description = "Memory allocated for ECS tasks"
  type        = string
  default     = "512"
}

variable "ecs_task_cpu" {
  description = "CPU allocated for ECS tasks"
  type        = string
  default     = "256"
}
