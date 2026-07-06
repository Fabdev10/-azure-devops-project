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
