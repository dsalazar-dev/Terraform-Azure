terraform {
  backend "azurerm" {
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "RG-TEST"
  location = var.location
}

// CREATING APP PLAN SERVICE - DOTNET 
resource "azurerm_app_service_plan" "APP_TEST_TERRAFORM_DOTNET_PLAN" {
  name                = "app-test-dotnet-terraform-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    environment       = var.environment
    owner_name        = var.owner_name
  }
}

// CREATING APP SERVICE - DOTNET 
resource "azurerm_app_service" "APP_TEST_TERRAFORM_DOTNET" {
  name                = "app-test-dotnet-terraform"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.APP_TEST_TERRAFORM_DOTNET_PLAN.id

  site_config {
    dotnet_framework_version = "v5.0"
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "dev"
  }

  tags = {
    environment       = var.environment
    owner_name        = var.owner_name
  }

}

// CREATING APP PLAN SERVICE - JAVA 
resource "azurerm_app_service_plan" "APP_TEST_TERRAFORM_JAVA_PLAN" {
  name                = "app-test-java-terraform-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = "Free"
    size = "T1"
  }

  tags = {
    environment       = var.environment
    owner_name        = var.owner_name
  }
}

// CREATING APP SERVICE - JAVA
resource "azurerm_app_service" "APP_TEST_TERRAFORM_JAVA" {
  name                = "app-test-java-terraform"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.APP_TEST_TERRAFORM_JAVA_PLAN.id

  site_config {
    java_version = "1.8"
    java_container = "Tomcat"
    java_container_version = "8.5"
  }

  tags = {
    environment       = var.environment
    owner_name        = var.owner_name
  }
}

// CREATING APP SERVICE - STATIC WEB
resource "azurerm_static_site" "STATIC_WEB" {
  name                = "app-test-static-terraform"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment       = var.environment
    owner_name        = var.owner_name
  }
}