# main.tf
provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "wordle" {
  name = "wordle-clone"
}

resource "aws_ecs_cluster" "wordle" {
  name = "wordle-cluster"
}

resource "aws_ecs_task_definition" "wordle" {
  family                   = "wordle"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = 256
  memory                  = 512

  container_definitions = jsonencode([
    {
      name  = "wordle"
      image = "${aws_ecr_repository.wordle.repository_url}:latest"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "wordle" {
  name            = "wordle-service"
  cluster         = aws_ecs_cluster.wordle.id
  task_definition = aws_ecs_task_definition.wordle.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.wordle.id]
    subnets         = var.subnet_ids
  }
}

