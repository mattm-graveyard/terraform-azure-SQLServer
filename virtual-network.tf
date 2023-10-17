resource "azurerm_virtual_network" "myvnet" {
  name = var.vn_name
  address_space = [ "10.0.0.0/16" ]
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
}

resource "azurerm_subnet" "mysubnet" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes = [ "10.0.2.0/24" ]
  service_endpoints = [ "Microsoft.Sql","Microsoft.Storage" ]
}

resource "azurerm_mssql_virtual_network_rule" "vnetrule" {
  name = var.sql_vn_rule_name
  server_id = azurerm_mssql_server.mysqlserver.id
  subnet_id = azurerm_subnet.mysubnet.id
}