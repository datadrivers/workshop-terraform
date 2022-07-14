output "access_key" {
  value       = azurerm_storage_account.state.primary_access_key
  description = "The primary access key for the storage account."
}
