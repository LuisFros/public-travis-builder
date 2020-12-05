resource "aws_alb" "entrega1-elb" {
    idle_timeout    = 60
    internal        = false
    name            = "entrega1-elb"
    security_groups = ["sg-4ecd3670", "sg-0f3d10ebe035fba5b"]
    subnets         = ["subnet-1ceb407a", "subnet-7096222f", "subnet-c80ff0f9", "subnet-da7ccafb", "subnet-e57b16eb", "subnet-e6443fab"]

    enable_deletion_protection = false

    tags = {
    }
}

