#we will create a security group with terraform dynamic block
resource "azurerm_network_security_group" "web_vmss_nsg" {
  name                = "${local.resource_name_prefix}-web-vmss-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  dynamic "security_rule" {
      for_each = var.web_vmss_inbound_ports
      content {
    name                       = "inbound-rule-${security_rule.key}"
    description                = "In Bount Rule ${security_rule.key}"
    priority                   = sum([100,security_rule.key])
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = security_rule.value 
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
}