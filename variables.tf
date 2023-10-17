variable "rg_name" {
  description = "Name of Resource Group"
  type = string
}

variable "rg_location" {
  description = "Location of Resource Group"
  type = string
}

variable "sql_server_name" {
  description = "Name of SQL Server"
  type = string
}

variable "sql_db_name" {
  description = "Name of SQL Database(s)"
  type = string
}

variable "sql_fw_name" {
  description = "Name of SQL Firewall Rule"
  type = string
}

variable "user_identity_name" {
  description = "Name of Assigned User Identity"
  type = string
}

variable "storage_name" {
  description = "Name of Storage Account"
  type = string
}

variable "private_endp_name" {
  description = "Name of Private Endpoint"
  type = string
}

variable "priv_service_conn_name" {
  description = "Name of Private Service Connection"
  type = string
}

variable "priv_dns_zone_group_name" {
  description = "Name of Private DNS Zone Group"
  type = string
}

variable "priv_dns_link" {
  description = "Link to Private DNS Zone"
  type = string
}

variable "priv_dns_zone_vnlink_name" {
  description = "Name of Private DNS Zone Virtual Network Link"
  type = string
}

variable "vn_name" {
    description = "Name of Virtual Network"
    type = string
}

variable "subnet_name" {
  description = "Name of Subnet"
  type = string
}

variable "sql_vn_rule_name" {
  description = "Name of SQL Virtual Network Rule"
  type = string
}

variable "key_vault_name" {
    description = "Name of Key Vault"
    type = string
}

variable "key_name" {
  description = "Name of Key in Key Vault"
  type = string
}
