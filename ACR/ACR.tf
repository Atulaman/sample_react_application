resource "azurerm_container_registry" "myregistry" {
  name                = "mikku1999"
  resource_group_name = azurerm_resource_group.react.name
  location            = azurerm_resource_group.react.location
  sku                 = "Standard"
  admin_enabled       = true
  network_rule_set {
    default_action = "Allow"  # Set default action to allow traffic
    //ip_rule ="0.0.0.0/0" # Allow traffic from all IP addresses
  }
}
