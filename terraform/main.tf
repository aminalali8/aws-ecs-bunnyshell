module "ecs_cluster" {
  source = "./modules/ecs_cluster"
  # Specify the necessary variables here
}

module "rds_database" {
  source = "./modules/rds_database"
  # Specify the necessary variables here
}

module "s3_bucket" {
  source = "./modules/s3_bucket"
  # Specify the necessary variables here
}

module "api_gateway" {
  source = "./modules/api_gateway"
  # Specify the necessary variables here
}
