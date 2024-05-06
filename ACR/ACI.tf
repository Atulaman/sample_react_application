# Create an Azure Container Instance
resource "azurerm_container_group" "example" {
  name                = "example-continst"
  location            = azurerm_resource_group.react.location
  resource_group_name = azurerm_resource_group.react.name
  ip_address_type     = "Public"
  //dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "react-app"
    image  = "mikku1999.azurecr.io/react"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}