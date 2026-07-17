module "networking" {
  source = "../../modules/networking"

  project               = var.project
  environment           = var.environment
  location              = var.location
  vnet_address_space    = var.vnet_address_space
  compute_subnet_prefix = var.compute_subnet_prefix
  data_subnet_prefix    = var.data_subnet_prefix
  aks_subnet_prefix     = var.aks_subnet_prefix
  allowed_ssh_ips       = var.allowed_ssh_ips

  tags = var.tags
}

module "compute" {
  source = "../../modules/compute"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.networking.resource_group_name
  subnet_id           = module.networking.compute_subnet_id
  public_ip_id        = module.networking.bastion_public_ip_id

  admin_ssh_public_key = var.admin_ssh_public_key

  tags = var.tags
}
module "database" {
  source = "../../modules/database"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.networking.resource_group_name
  vnet_id             = module.networking.vnet_id
  subnet_id           = module.networking.data_subnet_id

  admin_login    = var.db_admin_login
  admin_password = var.db_admin_password
  db_version     = var.db_version
  sku_name       = var.db_sku_name
  storage_mb     = var.db_storage_mb

  tags = var.tags
}

module "storage" {
  source = "../../modules/storage"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.networking.resource_group_name

  allowed_storage_ips = var.allowed_storage_ips
  compute_subnet_id   = module.networking.compute_subnet_id

  tags = var.tags
}

module "iam" {
  source = "../../modules/iam"

  project                       = var.project
  environment                   = var.environment
  location                      = var.location
  storage_account_id            = module.storage.storage_account_id
  managed_identity_principal_id = module.compute.managed_identity_principal_id

  tags = var.tags
}

# ---------------------------------------------------------------------------
# Fase 6 – ACR
# ---------------------------------------------------------------------------
module "acr" {
  source = "../../modules/acr"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.networking.resource_group_name

  tags = var.tags
}

# ---------------------------------------------------------------------------
# Fase 6 – AKS
# ---------------------------------------------------------------------------
module "aks" {
  source = "../../modules/aks"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.networking.resource_group_name
  subnet_id           = module.networking.aks_subnet_id
  acr_id              = module.acr.acr_id

  tags = var.tags
}
