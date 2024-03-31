location = "WestEurope"
VirtualNetworks = {
  vnet1 = {
    virtual_network_address_space = ["10.0.0.0/16"]

    vnet_name = "vnet"

    subnets = {}
  }
}

containerregistry = {
  name = "acr"
}

keyvault = {
  name = "KV"
}

app_service_plan = {
  name = "asp"
}