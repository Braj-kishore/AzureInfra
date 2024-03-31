#-------------------------------------------------
# Using Azure verified module for network security groups.
#https://github.com/Azure/terraform-azurerm-avm-res-containerregistry-registry
#--------------------------------------------------

module "avm-res-containerregistry-registry" {
  source                        = "Azure/avm-res-containerregistry-registry/azurerm"
  version                       = "0.1.0"
  name                          = var.containerregistry.name == null ? "acr${var.project_name}${var.environment}${var.location}001" : var.containerregistry.name
  resource_group_name           = azurerm_resource_group.rg[var.containerregistry.resource_groups_map_key].name
  location                      = azurerm_resource_group.rg[var.containerregistry.resource_groups_map_key].location
  public_network_access_enabled = var.containerregistry.public_network_access_enabled
  network_rule_bypass_option    = var.containerregistry.network_rule_bypass_option
  network_rule_set              = var.containerregistry.network_rule_set
  sku                           = var.containerregistry.sku
  zone_redundancy_enabled       = var.containerregistry.zone_redundancy_enabled
  diagnostic_settings = {
    enable_diagnostic = {
      workspace_resource_id = module.operationalinsights-workspace.workspace_id.id
    }
  }
  tags             = local.tags
  enable_telemetry = var.enable_telemetry
}