# --- root/main.tf ---

module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  access_ip        = var.access_ip
  security_groups  = local.security_groups
  public_sn_count  = 2
  private_sn_count = 3
  max_subnets      = 20
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}

module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "5.7.22"
  db_instance_class      = "db.t2.micro"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_identifier          = "squids-db"
  skip_db_snapshot       = true
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.db_security_group
}

module "loadbalancing" {
  source            = "./loadbalancing"
  listener_port     = 80
  listener_protocol = "HTTP"
  public_sg         = module.networking.public_sg
  public_subnets    = module.networking.public_subnets
  target_groups     = local.target_groups
  vpc_id            = module.networking.vpc_id
}

module "compute" {
  source              = "./compute"
  db_endpoint         = module.database.db_endpoint
  dbname              = var.dbname
  dbpassword          = var.dbpassword
  dbuser              = var.dbuser
  instance_count      = var.instance_count
  instance_type       = var.instance_type
  key_name            = var.key_name
  lb_target_group_arn = module.loadbalancing.lb_target_group_arn
  public_key_path     = var.public_key_path
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
  user_data_path      = "${path.root}/userdata.tpl"
  vol_size            = var.vol_size
}
