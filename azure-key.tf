resource "azurerm_key_vault" "mykeyvault" {
  name = var.key_vault_name
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days = 7
  purge_protection_enabled = true

   sku_name = "standard"

   access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Get", "List", "Create", "Delete", "Update", "Recover", "Purge", "GetRotationPolicy"]
   }

   access_policy {
    tenant_id = azurerm_user_assigned_identity.myuser.tenant_id
    object_id = azurerm_user_assigned_identity.myuser.principal_id

    key_permissions = [ "Get", "WrapKey", "UnwrapKey" ]
   } 
}

resource "azurerm_key_vault_key" "mykey" {
  depends_on = [ azurerm_key_vault.mykeyvault ]

  name = var.key_name
  key_vault_id = azurerm_key_vault.mykeyvault.id
  key_type = "RSA"
  key_size = 2048

  key_opts = ["unwrapKey", "wrapKey" ]
}