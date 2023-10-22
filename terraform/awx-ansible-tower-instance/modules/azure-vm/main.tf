resource "null_resource" "vm" {
  triggers = {
    my_ipaddress        = var.my_ipaddress
    ssh_public_key      = var.ssh_public_key
    azure_region        = var.azure_region
    azure_instance_type = var.azure_instance_type
  }
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "vm" {
  name     = "vm"
  location = var.azure_region
  tags = {
    environment = "vm"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "vm" {
  name                = "vm"
  address_space       = ["10.0.0.0/16"]
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.vm.name
  tags = {
    environment = "vm"
  }
}

# Create subnet
resource "azurerm_subnet" "vm" {
  name                 = "vm"
  resource_group_name  = azurerm_resource_group.vm.name
  virtual_network_name = azurerm_virtual_network.vm.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "vm" {
  name                = "vm"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
  allocation_method   = "Static"
  tags = {
    environment = "vm"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "vm" {
  name                = "vm"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.vm.name
  security_rule {
    name                         = "my_ipaddress"
    priority                     = 1001
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefixes      = ["${var.my_ipaddress}/32"]
    destination_address_prefixes = [azurerm_network_interface.vm.private_ip_address]
  }
  security_rule {
    name                         = "azurerm_public_ip"
    priority                     = 1002
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefixes      = ["${azurerm_public_ip.vm.ip_address}/32"]
    destination_address_prefixes = [azurerm_network_interface.vm.private_ip_address]
  }
  dynamic "security_rule" {
    for_each = var.whitelist_cidr

    content {
      name                         = "whitelist_cidr-${security_rule.key}"
      priority                     = security_rule.key
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "*"
      source_address_prefixes      = [security_rule.value]
      destination_address_prefixes = [azurerm_network_interface.vm.private_ip_address]
    }
  }
  tags = {
    environment = "vm"
  }
}

# Create network interface
resource "azurerm_network_interface" "vm" {
  name                = "vm"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.vm.name
  ip_configuration {
    name                          = "vm"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
  tags = {
    environment = "vm"
  }
}

data "template_file" "vm_user_data" {
  template = file("${path.module}/../../modules/shared/startup_script")
  vars = {
    TOWER_USERNAME = var.tower_username
    TOWER_PASSWORD = var.tower_password
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm"
  location              = var.azure_region
  size                  = var.azure_instance_type
  admin_username        = "ubuntu"
  resource_group_name   = azurerm_resource_group.vm.name
  network_interface_ids = [azurerm_network_interface.vm.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "ubuntu"
    public_key = var.ssh_public_key
  }
  custom_data = base64gzip(data.template_file.vm_user_data.rendered)
  tags = {
    environment = "vm"
  }
}
