# AzureInfra
Used Azure verified module (Terraform) for provision Azure resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.71.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.97.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm-res-containerregistry-registry"></a> [avm-res-containerregistry-registry](#module\_avm-res-containerregistry-registry) | Azure/avm-res-containerregistry-registry/azurerm | 0.1.0 |
| <a name="module_avm-res-keyvault-vault"></a> [avm-res-keyvault-vault](#module\_avm-res-keyvault-vault) | Azure/avm-res-keyvault-vault/azurerm | 0.5.3 |
| <a name="module_avm-res-network-privatednszone"></a> [avm-res-network-privatednszone](#module\_avm-res-network-privatednszone) | Azure/avm-res-network-privatednszone/azurerm | 0.1.1 |
| <a name="module_network"></a> [network](#module\_network) | Azure/avm-res-network-virtualnetwork/azurerm | 0.1.4 |
| <a name="module_networksecuritygroup"></a> [networksecuritygroup](#module\_networksecuritygroup) | Azure/avm-res-network-networksecuritygroup/azurerm | 0.1.1 |
| <a name="module_operationalinsights-workspace"></a> [operationalinsights-workspace](#module\_operationalinsights-workspace) | Azure/avm-res-operationalinsights-workspace/azurerm | 0.1.3 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan"></a> [app\_service\_plan](#input\_app\_service\_plan) | app service plan arguments definition. | <pre>object({<br>    name                                = optional(string)<br>    resource_groups_map_key             = optional(string, "default")<br>    os_type                             = optional(string, "Linux")<br>    sku                                 = optional(string, "Standard")<br>    app_service_environment_resource_id = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_contacts"></a> [contacts](#input\_contacts) | A map of contacts for the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. | <pre>map(object({<br>    email = string<br>    name  = optional(string, null)<br>    phone = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_containerregistry"></a> [containerregistry](#input\_containerregistry) | Create container registry for storing docker images. for argument details refer https://github.com/Azure/terraform-azurerm-avm-res-containerregistry-registry | <pre>object({<br>    name                          = optional(string)<br>    resource_groups_map_key       = optional(string, "default")<br>    public_network_access_enabled = optional(bool, false)<br>    network_rule_bypass_option    = optional(string, "AzureServices")<br>    sku                           = optional(string, "Standard")<br>    network_rule_set = optional(object({<br>      default_action = optional(string, "Deny")<br>      ip_rule = optional(list(object({<br>        # since the `action` property only permits `Allow`, this is hard-coded.<br>        action   = optional(string, "Allow")<br>        ip_range = string<br>      })), [])<br>      virtual_network = optional(list(object({<br>        # since the `action` property only permits `Allow`, this is hard-coded.<br>        action    = optional(string, "Allow")<br>        subnet_id = string<br>      })), [])<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment such as dev,UAT or prod | `string` | `"dev"` | no |
| <a name="input_keyvaults"></a> [keyvaults](#input\_keyvaults) | n/a | <pre>object({<br>    name                    = optional(string)<br>    resource_groups_map_key = optional(string, "default")<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the resource group/resources is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Create virtual network and subnets. In subnets map of object key is the name of the subnets. | <pre>map(object({<br>    vnet_name                     = string<br>    resource_groups_map_key       = optional(string, "network")<br>    virtual_network_address_space = list(string)<br>    subnets = map(object({<br>      address_prefixes                          = list(string)<br>      private_endpoint_network_policies_enabled = optional(bool, false)<br>      service_endpoints                         = optional(set(string))<br>      network_security_groups_map_key           = optional(string)<br>      delegations = optional(list(<br>        object(<br>          {<br>            name = string # (Required) A name for this delegation.<br>            service_delegation = object({<br>              name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.<br>              actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.<br>            })<br>          }<br>        )<br>      ))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | The network ACL configuration for the Key Vault.<br>If not specified then the Key Vault will be created with a firewall that blocks access.<br>Specify `null` to create the Key Vault with no firewall.<br><br>- `bypass` - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.<br>- `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.<br>- `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.<br>- `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`. | <pre>object({<br>    bypass                     = optional(string, "None")<br>    default_action             = optional(string, "Deny")<br>    ip_rules                   = optional(list(string), [])<br>    virtual_network_subnet_ids = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_network_security_groups"></a> [network\_security\_groups](#input\_network\_security\_groups) | Create network security groups and associated rules. | <pre>map(object({<br>    name                    = string<br>    resource_groups_map_key = optional(string, "network")<br>    rules = optional(map(object({<br>      nsg_rule_priority                   = number # (Required) NSG rule priority.<br>      nsg_rule_direction                  = string # (Required) NSG rule direction. Possible values are `Inbound` and `Outbound`.<br>      nsg_rule_access                     = string # (Required) NSG rule access. Possible values are `Allow` and `Deny`.<br>      nsg_rule_protocol                   = string # (Required) NSG rule protocol. Possible values are `Tcp`, `Udp`, `Icmp`, `Esp`, `Asterisk`.<br>      nsg_rule_source_port_range          = string # (Required) NSG rule source port range.<br>      nsg_rule_destination_port_range     = string # (Required) NSG rule destination port range.<br>      nsg_rule_source_address_prefix      = string # (Required) NSG rule source address prefix.<br>      nsg_rule_destination_address_prefix = string # (Required) NSG rule destination address prefix.<br>    })), {})<br>  }))</pre> | `{}` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project for which the infra will create. | `string` | `"POC"` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | map of object defines the details of the resource groups | <pre>map(object({<br>    name   = string<br>    region = optional(string)<br>  }))</pre> | <pre>{<br>  "default": {<br>    "name": "rg"<br>  },<br>  "network": {<br>    "name": "rg-network"<br>  },<br>  "privateDnsZones": {<br>    "name": "rg-dns"<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->