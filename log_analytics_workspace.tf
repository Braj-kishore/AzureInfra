
#-------------------------------------------------
# Using Azure verified module for log analytics workspace.
#https://github.com/Azure/terraform-azurerm-avm-res-network-virtualnetwork
#--------------------------------------------------
module "operationalinsights-workspace" {
  source              = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version             = "0.1.3"
  name                = "law-${local.resource_name_suffix}"
  resource_group_name = azurerm_resource_group.rg["default"].name
  location            = azurerm_resource_group.rg["default"].location
}