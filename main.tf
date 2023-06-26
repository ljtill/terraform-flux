#
# Services
#

resource "azurerm_resource_group" "main_services" {
  name     = "Services"
  location = ""

  tags = {}
}

module "services" {
  source = "./modules/services"

  resource_name       = ""
  location            = azurerm_resource_group.main_services.location
  resource_group_name = azurerm_resource_group.main_services.name

  tags = {}
}

#
# Cluster
#

resource "azurerm_resource_group" "main_cluster" {
  name     = "Cluster"
  location = ""

  tags = {}
}

module "cluster" {
  source = "./modules/cluster"

  resource_name       = ""
  location            = azurerm_resource_group.main_cluster.location
  resource_group_name = azurerm_resource_group.main_cluster.name

  registry_id = module.services.registry_id

  tags = {}
}

module "bootstrap" {
  source = "./modules/bootstrap"

  depends_on = [
    module.cluster
  ]
}
