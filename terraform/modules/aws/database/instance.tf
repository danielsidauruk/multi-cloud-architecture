
# This parameter group enables logical replication on the PostgreSQL instance
resource "aws_db_parameter_group" "postgres_replication" {
  name   = "postgres-replication-params"
  family = "postgres17"

  parameter {
    name         = "rds.logical_replication"
    value        = "1"
    apply_method = "pending-reboot"
  }
  # wal_level is automatically set to 'logical' when rds.logical_replication is enabled.
}

# Database Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
}

# This is the primary database instance (the Publisher)
resource "aws_db_instance" "postgres_primary_instance" {
  identifier             = "postgresql-primary-db-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "17.4" # Use a specific minor version
  username               = var.db_username
  password               = var.db_username_password
  db_name                = var.db_name
  parameter_group_name   = aws_db_parameter_group.postgres_replication.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres_security_group.id]
}
