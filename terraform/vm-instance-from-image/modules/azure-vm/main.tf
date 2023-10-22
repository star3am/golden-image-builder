resource "null_resource" "azurevm" {
  triggers = {
    my_ipaddress         = var.my_ipaddress
    ssh_public_key       = var.ssh_public_key
    azure_region         = var.azure_region
    azure_instance_type  = var.azure_instance_type
    image_version_number = var.image_version_number
  }
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "azurevm" {
  name     = "azurevm"
  location = var.azure_region
  tags = {
    environment = "azurevm"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "azurevm" {
  name                = "azurevm"
  address_space       = ["10.0.0.0/16"]
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.azurevm.name
  tags = {
    environment = "azurevm"
  }
}

# Create subnet
resource "azurerm_subnet" "azurevm" {
  name                 = "azurevm"
  resource_group_name  = azurerm_resource_group.azurevm.name
  virtual_network_name = azurerm_virtual_network.azurevm.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "azurevm" {
  name                = "azurevm"
  location            = azurerm_resource_group.azurevm.location
  resource_group_name = azurerm_resource_group.azurevm.name
  allocation_method   = "Static"
  tags = {
    environment = "azurevm"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_ipaddress" {
  name                = "azurevm"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.azurevm.name
  security_rule {
    name                         = "myipaddress"
    priority                     = 1001
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefixes      = ["${var.my_ipaddress}/32"]
    destination_address_prefixes = [azurerm_network_interface.azurevm.private_ip_address]
  }
  security_rule {
    name                         = "azurerm_public_ip"
    priority                     = 1002
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefixes      = ["${azurerm_public_ip.azurevm.ip_address}/32"]
    destination_address_prefixes = [azurerm_network_interface.azurevm.private_ip_address]
  }
  security_rule {
    name                         = "towerhost"
    priority                     = 1003
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefixes      = ["${var.tower_host}/32"]
    destination_address_prefixes = [azurerm_network_interface.azurevm.private_ip_address]
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
      destination_address_prefixes = [azurerm_network_interface.azurevm.private_ip_address]
    }
  }
  tags = {
    environment = "azurevm"
  }
}

# Create network interface
resource "azurerm_network_interface" "azurevm" {
  name                = "azurevm"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.azurevm.name
  ip_configuration {
    name                          = "azurevm"
    subnet_id                     = azurerm_subnet.azurevm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.azurevm.id
  }
  tags = {
    environment = "azurevm"
  }
}

data "template_file" "vm_user_data" {
  count = var.is_windows ? 0 : 1

  template = file("${path.module}/../../modules/shared/startup_script")
  vars = {
    VM_IP       = azurerm_public_ip.azurevm.ip_address
    VM_PASSWORD = var.vm_password
    VM_USERNAME = var.vm_username
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "azurevm" {
  count = var.is_windows ? 0 : 1

  name                            = "azurevm"
  location                        = var.azure_region
  size                            = var.azure_instance_type
  admin_username                  = "ubuntu" #var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  resource_group_name             = azurerm_resource_group.azurevm.name
  network_interface_ids           = [azurerm_network_interface.azurevm.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = local.source_image_id

  /*
  admin_ssh_key {
    username   = var.vm_username
    public_key = var.ssh_public_key
  }
  */

  custom_data = base64gzip(data.template_file.vm_user_data[0].rendered)
  tags = {
    environment = "azurevm"
  }
}

resource "azurerm_windows_virtual_machine" "azurevm" {
  count = var.is_windows ? 1 : 0

  name                = "azurevm"
  resource_group_name = azurerm_resource_group.azurevm.name
  location            = var.azure_region
  size                = var.azure_instance_type
  # TODO: FIXME
  admin_username        = var.windows_admin_username
  admin_password        = var.windows_admin_password
  network_interface_ids = [azurerm_network_interface.azurevm.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = local.source_image_id

}

resource "null_resource" "awx_cli" {
  triggers = {
    timestamp = local.timestamp
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../modules/shared"
    command     = "/bin/bash tower_callback_script"

    environment = {
      TOWER_HOST           = var.tower_host
      TOWER_USERNAME       = var.tower_username
      TOWER_PASSWORD       = var.tower_password
      VM_PUBLIC_IP_ADDRESS = azurerm_public_ip.azurevm.ip_address
      VM_NAME              = "azurevm"
    }
  }

  depends_on = [
    azurerm_linux_virtual_machine.azurevm
  ]
}
