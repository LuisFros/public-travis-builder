resource "aws_security_group" "EC2-Security-Group" {
    name        = "launch-wizard-1"
    description = "launch-wizard-1 created 2020-09-29T22:41:11.749-03:00"
    vpc_id      = aws_vpc.Main-VPC.id
    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks     = ["::/0"]
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks     = ["::/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        "Name" = "EC2-Security-Group"
    }
}

resource "aws_security_group" "RDS-Security-Group" {
    name        = "db-sg"
    description = "database RDS"
    vpc_id      = "vpc-4a6baf37"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = ["sg-0f3d10ebe035fba5b"]
        self            = false
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    tags= {
        "Name" = "RDS-Security-Group"
    }

}

resource "aws_security_group" "Default" {
    name        = "default"
    description = "default VPC security group"
    vpc_id      = "vpc-4a6baf37"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 6379
        to_port         = 6379
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks     = ["::/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
      "name" = "Default"
    }

}

