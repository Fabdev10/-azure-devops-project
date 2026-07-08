module "networking" {
  source = "../../modules/networking"

  project               = var.project
  environment           = var.environment
  location              = var.location
  vnet_address_space    = var.vnet_address_space
  compute_subnet_prefix = var.compute_subnet_prefix
  data_subnet_prefix    = var.data_subnet_prefix
  allowed_ssh_ips       = var.allowed_ssh_ips
  
  tags = var.tags
}

module "compute" {
  source = "../../modules/compute"

  project               = var.project
  environment           = var.environment
  location              = var.location
  resource_group_name   = module.networking.resource_group_name
  subnet_id             = module.networking.compute_subnet_id
  public_ip_id          = module.networking.bastion_public_ip_id
  
  admin_ssh_public_key  = var.admin_ssh_public_key
  
  tags = var.tags
}

