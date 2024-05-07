# Create an Azure Container Instances
resource "azurerm_container_group" "example" {
  name                = "example-continst"
  location            = azurerm_resource_group.react.location
  resource_group_name = azurerm_resource_group.react.name
  ip_address_type     = "Public"
  restart_policy = "OnFailure"
  os_type             = "Linux"
  image_registry_credential {
    username = azurerm_container_registry.myregistry.admin_username
    password = azurerm_container_registry.myregistry.admin_password
    server = azurerm_container_registry.myregistry.login_server
  }

  container {
    name   = "react-app"
    image  = "${azurerm_container_registry.myregistry.login_server}/react:latest"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_container_registry.myregistry]
}

# Grant access for ACI to pull images from ACR
/*data "azurerm_role_definition" "acr_pull_role" {
  name = "AcrPull"
}

resource "azurerm_role_assignment" "acr_pull_assignment" {
  scope                = azurerm_container_registry.myregistry.id
  role_definition_id   = data.azurerm_role_definition.acr_pull_role.id
  principal_id         = azurerm_container_group.example.identity[0].principal_id
  skip_service_principal_aad_check = true
}*/