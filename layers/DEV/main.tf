# Below are the list of resource to create Application Infrastructure
module "naveen_vpc" {
  source = "../../modules/naveen_aws_core_module/vpc"

  region = "eu-central-1"
  account_id = "449701711604"
  vpc_cidr   = "192.168.0.0/16"
  environment = "dev"
  public       = ["192.168.0.0/24", "192.168.3.0/24", "192.168.6.0/24"]
  private_app  = ["192.168.1.0/24", "192.168.4.0/24", "192.168.7.0/24"]
  private_db = ["192.168.2.0/24", "192.168.5.0/24", "192.168.8.0/24"]
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_name           = "application"
  vpc_flow_log_group_name = "application"
  sub_services_names = {
    public       = "pub"
    private_app  = "pri"
    private_db = "db"
  }
  common_tags = {
    Environment = "development"
  }

}

module "naveen_application_server" {
  source = "../../modules/naveen_aws_core_module/ec2instance"

  application = var.application
  environment = var.environment
  ec2_name    = "${var.application}}-${var.environment}-ec2"
  vpc_id      = module.naveen_vpc.vpcid
  ami_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.EC2_KEYPAIR_NAME
  subnetid      = [module.naveen_vpc.pubsubnet1]
}
