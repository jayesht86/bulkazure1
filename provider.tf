terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
provider "azurerm" {
  features {
    #skip_provider_registration = true
  }
  subscription_id = "59bab8f2-1319-472b-bb69-314d1b034ec0"
}
