output "sql_server_name" {
  value = azurerm_mssql_server.mysqlserver.name
  sensitive = true
}

output "sql_server_id" {
  value = azurerm_mssql_server.mysqlserver.id
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.storagehold.name
  sensitive = true
}

output "storage_account_id" {
  value = azurerm_storage_account.storagehold.id
  sensitive = true
}