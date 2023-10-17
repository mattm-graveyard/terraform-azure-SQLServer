data "azurerm_client_config" "current" {            #Access config Credentials of current AzureRM Provider
}

data "hcp_vault_secrets_secret" "secret_user" {     #Access Credentials for SQL Server from Vault Secrets
  app_name = "practice-vault"
  secret_name = "sqladmin"
}

data "hcp_vault_secrets_secret" "secret_password" {
  app_name = "practice-vault"
  secret_name = "sqlpassword"
}
