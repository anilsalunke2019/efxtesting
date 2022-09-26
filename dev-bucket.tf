resource "google_storage_bucket" "DEV-bucket" {
  name = "efx-bucket-dev"
  storage_class = "STANDARD"
  location = "US-EAST1"

}