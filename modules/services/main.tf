#
# Container Registry
#

resource "azurerm_container_registry" "main" {
  name                = var.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku           = "Premium"
  admin_enabled = false

  tags = var.tags
}
