variable "RDS_PASSWORD" {
  description = "The PASSWORD for the DB master user"
  type        = string
  sensitive = true
}
resource "aws_db_instance" "ec2-database" {
    identifier                = "ec2-database"
    allocated_storage         = 20
    storage_type              = "gp2"
    engine                    = "postgres"
    engine_version            = "12.3"
    instance_class            = "db.t2.micro"
    username                  = "postgres"
    password                  = var.RDS_PASSWORD
    port                      = 5432
    publicly_accessible       = false
    availability_zone         = "us-east-1f"
    skip_final_snapshot       = true
    security_group_names      = []
    copy_tags_to_snapshot     =  true
    vpc_security_group_ids    = ["sg-0f6314bb2cfa8e52b", "sg-0f3d10ebe035fba5b", "sg-4ecd3670"]
    db_subnet_group_name      = "default-vpc-4a6baf37"
    parameter_group_name      = "default.postgres12"
    multi_az                  = false
    backup_retention_period   = 7
    backup_window             = "07:06-07:36"
    maintenance_window        = "wed:08:17-wed:08:47"
    max_allocated_storage     = 1000
    monitoring_interval       = 0


}
