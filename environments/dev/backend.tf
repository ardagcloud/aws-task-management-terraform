terraform {
  backend "s3" {
    bucket       = "ardagcloud-taskmanagement-tfstate-35afdwaf214"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}