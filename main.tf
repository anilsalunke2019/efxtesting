terraform {
  backend "gcs" {
    bucket = "ngtest-356407-tfstate"
   #credentials = file(var.credentials_file)
  #credentials = "C:\key\ngtest-356407-b7b1d75e8b5b.json"
  }
}
