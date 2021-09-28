resource "aws_ecs_service" "ecs_service" {
  name            = "${var.task_definition_family_name}_service"
  cluster         = var.cluster_resource.id
  task_definition = aws_ecs_task_definition.ecs_task_def.arn
  desired_count   = var.desired_task_count
  depends_on = [
    aws_iam_role_policy.execution_policy,
    aws_lb.load_balancer,
    aws_lb_listener.load_balancer_listener
  ]

  force_new_deployment = false
  launch_type          = "FARGATE"

  network_configuration {
    subnets          = var.service_allowable_subnets
    security_groups  = var.service_security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group.arn
    container_name   = var.task_container_name
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  tags = {
    Terraform = true
  }
}
