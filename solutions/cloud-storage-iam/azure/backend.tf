terraform {
  backend "azurerm" {
    storage_account_name = "workshoptfstateam"
    container_name       = "state"
    key                  = "terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = "abcdefghijklmnopqrstuvwxyz0123456789..."
  }
}
