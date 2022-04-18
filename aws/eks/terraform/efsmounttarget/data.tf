data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../eks/terraform.tfstate"
  }
}
data "terraform_remote_state" "efs" {
  backend = "local"
  config = {
    path = "../efs/terraform.tfstate"
  }
}
