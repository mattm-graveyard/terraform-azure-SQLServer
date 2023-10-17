resource "azurerm_mssql_server" "mysqlserver" {
  name = "${var.sql_server_name}${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  version = "12.0"
  administrator_login = data.hcp_vault_secrets_secret.secret_user.secret_value
  administrator_login_password = data.hcp_vault_secrets_secret.secret_password.secret_value
  minimum_tls_version = "1.2"

  azuread_administrator {
    login_username = azurerm_user_assigned_identity.myuser.name
    object_id = azurerm_user_assigned_identity.myuser.principal_id
  }

  identity {
    type = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.myuser.id ]
  }

  primary_user_assigned_identity_id = azurerm_user_assigned_identity.myuser.id
  transparent_data_encryption_key_vault_key_id = azurerm_key_vault_key.mykey.id
}

resource "azurerm_mssql_database" "sqldatabase" {
  name = var.sql_db_name
  server_id = azurerm_mssql_server.mysqlserver.id
  max_size_gb = 2
  sku_name = "Basic"

  long_term_retention_policy {                          # workaround for long_term_retention_policy error while running terraform apply 
    weekly_retention = "P45D"
  }

}

resource "azurerm_mssql_firewall_rule" "firewall" {
    name = var.sql_fw_name
    server_id = azurerm_mssql_server.mysqlserver.id
    start_ip_address = "0.0.0.0"                        #Change if possible 
    end_ip_address = "0.0.0.0"
  
}

resource "azurerm_mssql_server_extended_auditing_policy" "auditsql" {                           #Server audit record that will extend to all databases created in this server
  server_id = azurerm_mssql_server.mysqlserver.id
  storage_endpoint = azurerm_storage_account.storagehold.primary_blob_endpoint
  storage_account_access_key = azurerm_storage_account.storagehold.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days = 6
}