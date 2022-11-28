resource "azuread_application" "azure_application" {
  display_name = var.app_name
}
resource "azuread_service_principal" "azure_sp" {
  application_id = azuread_application.azure_application.application_id
}
resource "azuread_application_password" "azure_application_pw" {
  application_object_id   = azuread_application.azure_application.object_id
  end_date_relative       = var.time
}