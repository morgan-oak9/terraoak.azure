
resource "azurerm_resource_group" "sac_healthcare" {
  name     = "sac-testing-function-resource-group"
  location = "East US 2"
}

resource "azurerm_healthcare_service" "sac_healthcare_apis" {
  name                = "sac-healthcare-apis"
  resource_group_name = azurerm_resource_group.sac_healthcare.name
  location            = azurerm_resource_group.sac_healthcare.location
  kind                = "fhir-R4"
  cosmosdb_throughput = "2000"
  cors_configuration {
    allowed_origins    = ["PUT", "*"]
    allowed_methods    = ["DELETE", "PUT"] # oak9: cors_configuration.allowed_methods should be set to any of get, put, post
    max_age_in_seconds = "500"
    allow_credentials  = "true"
  }
}