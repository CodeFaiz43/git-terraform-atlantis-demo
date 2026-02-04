module "network" {
  source = "./network"
  # this is a variable defined in variables.tf file
  ssh_public_key = var.ssh_public_key
}
