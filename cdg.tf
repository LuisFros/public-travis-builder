
resource "aws_codedeploy_app" "finalApp" {
  name = "finalApp"
}

resource "aws_codedeploy_deployment_group" "finalDeploymentGroup" {
  app_name              = aws_codedeploy_app.finalApp.name
  deployment_group_name = "finalDeploymentGroup"
  service_role_arn      = aws_iam_role.iamrole-codedeploy.arn
  autoscaling_groups = [ aws_autoscaling_group.autoscalingV3.name ]
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  deployment_style {
                deployment_option= "WITH_TRAFFIC_CONTROL"
                deployment_type=  "IN_PLACE"
  }
  load_balancer_info {
    target_group_info {
      name= "ec2-target-group"
    }
    
  }
}