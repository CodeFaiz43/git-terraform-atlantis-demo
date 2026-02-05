terraform {
  backend "gcs" {
    bucket = "tf-state-tf-project-486307"
    prefix = "network"
  }
}
