locals {
  resource_name_suffix = "${var.project_name}-${var.environment}-${var.location}-001"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }

  privatednszones = {
    postgres = "privatelink.postgres.database.azure.com"
    keyvault = "privatelink.vaultcore.azure.net"
  }

  role_assignments = {
    current_MSI = {
      role_definition_id_or_name = "Key Vault Secrets Officer"
      principal_id               = data.azurerm_client_config.current.object_id
    }
  }

}