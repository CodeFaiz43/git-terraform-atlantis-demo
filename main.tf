module "network" {
  source = "./network"

  ssh_public_key = var.ssh_public_key
}
