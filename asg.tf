resource "aws_launch_template" "ec2-template" {
  name= "ec2-template"
  description =  "withGoogleNewRelic"
  name_prefix   = null
  image_id      = "ami-068aa8a4be8f367f9"
  instance_type = "t2.micro"
  disable_api_termination = false
  ebs_optimized = false
  iam_instance_profile  {
     arn= "arn:aws:iam::564835583352:instance-profile/aws-opsworks-ec2-role"
  }
  key_name = "entrega0-ec2"
  ram_disk_id = ""
  vpc_security_group_ids = ["sg-0f3d10ebe035fba5b"]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ec2"
    }
  }
  user_data= base64encode(<<USER_DATA
    #!/bin/bash
    sudo apt-get update -y
    sudo apt  install awscli -y
    ## INSTALL DOCKER
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo usermod -aG docker ubuntu

    # Install docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo apt-get install ruby -y
    sudo apt-get install wget -y
    cd /home/ubuntu
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
    sudo chmod +x ./install
    sudo ./install auto
    sudo service codedeploy-agent start
    USER_DATA
    )
}



resource "aws_autoscaling_group" "autoscalingV3" {
    desired_capacity          = 1
    health_check_grace_period = 300
    health_check_type         = "EC2"
    max_size                  = 1
    min_size                  = 1
    name                      = "autoscalingV3"
    vpc_zone_identifier       = ["subnet-da7ccafb", "subnet-e57b16eb", "subnet-c80ff0f9", "subnet-e6443fab", "subnet-1ceb407a", "subnet-7096222f"]
    target_group_arns=  [
              "arn:aws:elasticloadbalancing:us-east-1:564835583352:targetgroup/ec2-target-group/007c44806162eb02"
            ]
    launch_template {
        id      = aws_launch_template.ec2-template.id
        version = "$Latest"
    }

    tag {
        key   = "name"
        value = "ec2"
        propagate_at_launch = true
    }
    
}
