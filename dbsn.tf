resource "aws_db_subnet_group" "default-vpc-4a6baf37" {
    name        = "default-vpc-4a6baf37"
    description = "Created from the RDS Management Console"
    subnet_ids  = ["subnet-7096222f", "subnet-1ceb407a", "subnet-e6443fab", "subnet-c80ff0f9", "subnet-e57b16eb", "subnet-da7ccafb"]
}

