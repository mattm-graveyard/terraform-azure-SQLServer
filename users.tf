resource "azurerm_user_assigned_identity" "myuser" {
  name = var.user_identity_name
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}