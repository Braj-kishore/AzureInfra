location = "WestEurope"
VirtualNetworks = {
  vnet1 = {
    virtual_network_address_space = ["10.0.0.0/16"]

    vnet_name = "vnet"

    subnets = {
      app-subnet-weu-001 = {
        address_prefixes                = ["10.0.0.0/27"]
        service_endpoints               = ["Microsoft.KeyVault"]
        network_security_groups_map_key = "app_subnet_nsg"
        delegations = [{
          name = "app-delegation-dev-weu-001"
          service_delegation = {
            name    = "Microsoft.Web/serverFarms"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
          }
          }
        ]
      }
      postgres-subnet-weu-001 = {
        address_prefixes                = ["10.0.1.0/28"]
        network_security_groups_map_key = "postgres_subnet_nsg"
        service_endpoints               = ["Microsoft.storage"]
        delegations = [{
          name = "postgres-delegation-dev-weu-001"
          service_delegation = {
            name    = "Microsoft.DBforPostgreSQL/flexibleServers"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
          }
          }
        ]
      }
    }
  }
}

network_security_groups = {
  app_subnet_nsg = {
    name = "app-nsg-weu-001"
  }
  postgres_subnet_nsg = {
    name = "postgres-nsg-weu-001"
    rules = {
      allow_app = {
        nsg_rule_priority                   = 100
        nsg_rule_direction                  = "Inbound"
        nsg_rule_access                     = "Allow"
        nsg_rule_protocol                   = "Tcp"
        nsg_rule_source_port_range          = "*"
        nsg_rule_destination_port_range     = "5432"
        nsg_rule_source_address_prefix      = "10.0.0.0/27"
        nsg_rule_destination_address_prefix = "10.0.1.0/28"
      }
    }
  }
}

containerregistry = {
  name = "acrdevweu01"
}

keyvault = {
  name = "kv-dev-weu-001"
}

app_service_plan = {
  name = "asp"
}

log_analytics_workspace = {
  name = "law-dev-weu-001"
}