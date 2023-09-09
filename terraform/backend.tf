terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "path-to-key"
    region = "us-west-2"
    profile = "myprofile"
    encrypt = true
    versioning = true
  }
}
