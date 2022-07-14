resource "azurerm_resource_group" "rg" {
  name     = "terraform-workshop-execise2"
  location = "West Europe"
}

resource "azurerm_storage_account" "state" {
  name                     = "workshoptfstateam"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state" {
  name                  = "state"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}
