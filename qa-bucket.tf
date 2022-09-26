resource "google_storage_bucket" "QA-bucket" {
  name = "efx-bucket-qa"
  storage_class = "STANDARD"
  location = "US-EAST1"
}