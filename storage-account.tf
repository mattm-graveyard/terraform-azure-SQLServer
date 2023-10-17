resource "azurerm_storage_account" "storagehold" {
  name = "${var.storage_name}${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"

  network_rules {
    default_action = "Deny"
    ip_rules = [ "100.0.0.1" ]
    virtual_network_subnet_ids = [ azurerm_subnet.mysubnet.id ]
    bypass = [ "AzureServices" ]
  }
}

resource "azurerm_private_endpoint" "endpoint" {
  name = var.private_endp_name
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  subnet_id = azurerm_subnet.mysubnet.id

  private_service_connection {
    name = var.priv_service_conn_name
    private_connection_resource_id = azurerm_storage_account.storagehold.id
    is_manual_connection = false
    subresource_names = [ "blob" ]
  }

  private_dns_zone_group {
    name = var.priv_dns_zone_group_name
    private_dns_zone_ids = [azurerm_private_dns_zone.dnszone.id]
  }
}

resource "azurerm_private_dns_zone" "dnszone" {
  name = var.priv_dns_link
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnsvnetlink" {
  name = var.priv_dns_zone_vnlink_name
  resource_group_name = azurerm_resource_group.myrg.name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone.name
  virtual_network_id = azurerm_virtual_network.myvnet.id
}