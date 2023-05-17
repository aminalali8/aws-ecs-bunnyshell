resource "aws_db_instance" "rds_instance" {
  identifier           = var.db_instance_identifier
  allocated_storage    = var.allocated_storage
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  backup_retention_period = var.backup_retention_period
}
