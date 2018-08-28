
terraform {
  backend "s3" {
    bucket = "kwnetapps-terraform-state"
    key = "kwnetapps/terraform.tfstate"
    region = "us-west-2"
  }
}
