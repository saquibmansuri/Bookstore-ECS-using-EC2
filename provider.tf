# THIS FILE CONTAINS ALL THE PROVIDERS USED IN THE PROJECT


provider "aws" {
  access_key = ""  #${{ secrets.ACCESS_KEY }}
  secret_key = ""  #${{ secrets.SECRET_KEY }}
  region     = var.region
  #shared_credentials_files = "C:/Users/admin/.aws/credentials"
}


