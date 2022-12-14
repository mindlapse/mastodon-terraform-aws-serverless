
module "network" {
  source = "./module"

  vpc_cidr_prefix = "10.0"
  num_azs         = 2
}
