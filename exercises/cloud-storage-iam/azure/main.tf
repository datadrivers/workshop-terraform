locals {
  files = fileset(path.module, "*")
}

data "azurerm_client_config" "example" {}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-workshop-execise3"
  location = "West Europe"
}

resource "azurerm_storage_account" "store" {
  name                     = "workshoptfstoream"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "store" {
  name                  = "store"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "files" {
  for_each = local.files

  name                   = each.value
  storage_account_name   = azurerm_storage_account.store.name
  storage_container_name = azurerm_storage_container.store.name
  type                   = "Block"
  source                 = each.value
}

resource "azurerm_role_assignment" "readers" {
  scope                = azurerm_storage_account.store.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.example.object_id
}
