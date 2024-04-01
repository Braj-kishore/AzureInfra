location = "WestEurope"
VirtualNetworks = {
  vnet1 = {
    virtual_network_address_space = ["10.0.0.0/16"]

    vnet_name = "vnet"

    subnets = {}
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