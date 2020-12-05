# resource "aws_instance" "backend-api" {
#     ami                         = "ami-068aa8a4be8f367f9"
#     availability_zone           = "us-east-1a"
#     ebs_optimized               = false
#     instance_type               = "t2.micro"
#     monitoring                  = false
#     disable_api_termination = false
#     hibernation = false
#     key_name                    = "entrega0-ec2"
#     subnet_id                   = "subnet-7096222f"
#     associate_public_ip_address = true
#     private_ip                  = "172.31.45.148"
#     source_dest_check           = true
#     iam_instance_profile        = "aws-opsworks-ec2-role"
#     user_data = "b109b3a07bc4d58bd4c769dc9c9cea263adb5154"
#     root_block_device {
#         volume_type           = "gp2"
#         volume_size           = 8
#         delete_on_termination = true
#     }
#     security_groups = [ aws_security_group.EC2-Security-Group.name ]

#     tags = {
#         "name" = "ec2"
#     }
# }

