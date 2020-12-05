resource "aws_subnet" "Subnet1" {
    vpc_id                  = "vpc-4a6baf37"
    cidr_block              = "172.31.80.0/20"
    availability_zone       = "us-east-1c"
    map_public_ip_on_launch = true

    tags = {
    }
}

resource "aws_subnet" "Subnet2" {
    vpc_id                  = "vpc-4a6baf37"
    cidr_block              = "172.31.64.0/20"
    availability_zone       = "us-east-1f"
    map_public_ip_on_launch = true

    tags = {
    }
}

resource "aws_subnet" "Subnet3" {
    vpc_id                  = "vpc-4a6baf37"
    cidr_block              = "172.31.48.0/20"
    availability_zone       = "us-east-1e"
    map_public_ip_on_launch = true

    tags = {
    }
}

resource "aws_subnet" "Subnet4" {
    vpc_id                  = "vpc-4a6baf37"
    cidr_block              = "172.31.16.0/20"
    availability_zone       = "us-east-1d"
    map_public_ip_on_launch = true

    tags = {
    }
}

resource "aws_subnet" "Subnet5" {
    vpc_id                  = "vpc-4a6baf37"
    cidr_block              = "172.31.0.0/20"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
    }
}

resource "aws_subnet" "Subnet6" {
    vpc_id                  = "vpc-4a6baf37"
    cidr_block              = "172.31.32.0/20"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
    }
}

