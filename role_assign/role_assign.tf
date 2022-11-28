resource "azurerm_role_assignment" "ra" {
  scope                = var.scope
  role_definition_name = var.role
  principal_id         = var.sp_id
}