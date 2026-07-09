resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_vnet_link" {
  name                  = "${var.project}-${var.environment}-pg-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                          = "${var.project}-${var.environment}-pg-${var.location}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.db_version
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id
  administrator_login           = var.admin_login
  administrator_password        = var.admin_password
  storage_mb                    = var.storage_mb
  sku_name                      = var.sku_name
  public_network_access_enabled = false

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres_vnet_link]

  tags = var.tags
}
