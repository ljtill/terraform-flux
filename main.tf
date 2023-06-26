#
# Services
#

resource "azurerm_resource_group" "main_services" {
  name     = "Services"
  location = var.location

  tags = {}
}

module "services" {
  source = "./modules/services"

  resource_name       = var.services_resource_name
  location            = azurerm_resource_group.main_services.location
  resource_group_name = azurerm_resource_group.main_services.name

  tags = {}
}

#
# Cluster
#

resource "azurerm_resource_group" "main_cluster" {
  name     = "Cluster"
  location = var.location

  tags = {}
}

module "cluster" {
  source = "./modules/cluster"

  resource_name       = var.cluster_resource_name
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
