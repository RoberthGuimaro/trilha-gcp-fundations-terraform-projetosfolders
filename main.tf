provider "google" {
  project = "guimaro-devops-iac"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent       = "organizations/570228649030"
}

resource "google_folder" "SalesForce" {
  display_name = "SalesForce"
  parent       = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent       = google_folder.SalesForce.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent       = google_folder.SalesForce.name
}


resource "google_project" "guimaro-salesforce-dev" {
  name       = "SalesForce-Dev"
  project_id = "guimaro-salesforce-dev"
  folder_id  = google_folder.Desenvolvimento.name
  auto_create_network=false
  billing_account = "198945-C8270P-33F8R9"

}

resource "google_project" "guimaro-salesforce-prod" {
  name       = "SalesForce-Prod"
  project_id = "guimaro-salesforce-prod"
  folder_id  = google_folder.Producao.name
  auto_create_network=false
  billing_account = "198945-C8270P-33F8R9"
 }

 resource "google_folder" "Comercial" {
  display_name = "Comercial"
  parent       = "organizations/570228649030"
}

resource "google_folder" "Mobile" {
  display_name = "Mobile"
  parent       = google_folder.comercial.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent       = google_folder.Mobile.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent       = google_folder.Mobile.name
}


resource "google_project" "guimaro-comercial-mobile-dev" {
  name       = "Comercial-Mobile-Dev"
  project_id = "guimaro-comercial-mobile-dev"
  folder_id  = google_folder.Desenvolvimento.name
  auto_create_network=false
  billing_account = "198945-C8270P-33F8R9"

}

resource "google_project" "guimaro-comercial-mobile-prod" {
  name       = "Comercial-Mobile-Prod"
  project_id = "guimaro-comercial-mobile-prod"
  folder_id  = google_folder.Producao.name
  auto_create_network=false
  billing_account = "198945-C8270P-33F8R9"
 }