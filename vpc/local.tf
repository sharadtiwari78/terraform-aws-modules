locals {
  vpc_name            = "ffng-vpc-01"
  public_subnet_name  = "ffng-public-subnet0"
  private_subnet_name = "ffng-private-subnet0"
  db_subnet_name      = "ffng-db-subnet0"
  public_rtb_name     = "ffng-route-public-01"
  private_rtb_name    = "ffng-route-private-01"
  db_rtb_name         = "ffng-db-private-01"
  nat_gw_name         = "ffng-nat-01"
  eip_name            = "ffng-eip-01"
  igw_name            = "ffng-igw-01" 
  azs                 = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    env         = var.env
    project     = "Demo_project"
    Terraform   = "true"
  }
}