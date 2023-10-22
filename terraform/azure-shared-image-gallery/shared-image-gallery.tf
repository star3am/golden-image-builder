/*
resource "azurerm_resource_group" "rg" {
  name     = "resourcegroup"
  location = "Australia East"
}
*/

resource "azurerm_shared_image_gallery" "sig" {
  name                = var.custom_image_gallery_name
  resource_group_name = var.resource_group
  location            = var.location
  description         = "Shared Image Gallery"
}

resource "azurerm_shared_image" "ubuntu2004" {
  name                = "ubuntu-2004"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "ubuntu-com-server-focal"
    sku       = "20_04-lts-gen2"
  }
}

resource "azurerm_shared_image" "ubuntu1804" {
  name                = "ubuntu-1804"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "ubuntu-com-server-bionic"
    sku       = "18_04-lts-gen2"
  }
}

resource "azurerm_shared_image" "centos79" {
  name                = "centos-79"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "centos-com-server-79"
    sku       = "centos-79"
  }
}

resource "azurerm_shared_image" "centos83" {
  name                = "centos-83"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "centos-com-server-83"
    sku       = "centos-83"
  }
}

resource "azurerm_shared_image" "redhat79" {
  name                = "redhat-79"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "redhat-com-server-79"
    sku       = "redhat-79"
  }
}

resource "azurerm_shared_image" "redhat83" {
  name                = "redhat-83"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "redhat-com-server-83"
    sku       = "redhat-83"
  }
}

resource "azurerm_shared_image" "windows2019" {
  name                = "windows-2019"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Windows"
  hyper_v_generation  = "V1"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "microsoft-com-server-2019"
    sku       = "windows-2019"
  }
}

resource "azurerm_shared_image" "windows2016" {
  name                = "windows-2016"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Windows"
  hyper_v_generation  = "V1"
  identifier {
    publisher = var.custom_image_publisher
    offer     = "microsoft-com-server-2016"
    sku       = "windows-2016"
  }
}
