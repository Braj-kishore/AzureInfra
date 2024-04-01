location = "WestEurope"
VirtualNetworks = {
  vnet1 = {
    virtual_network_address_space = ["10.0.0.0/16"]

    vnet_name = "vnet"

    subnets = {}
  }
}

containerregistry = {
  name = "acrdevweu001"
}

keyvault = {
  name = "kv-dev-weu-01"
}

app_service_plan = {
  name = "asp"
}

log_analytics_workspace = {
  name = "law-dev-weu-001"
}