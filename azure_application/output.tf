output "display_name"{
    value= azuread_service_principal.azure_sp.display_name
}
output "app_id"{
    value= azuread_service_principal.azure_sp.application_id
}
output "obj_id"{
    value= azuread_service_principal.azure_sp.object_id
}
output "secret"{
    value = azuread_application_password.azure_application_pw.value
    sensitive=true
}