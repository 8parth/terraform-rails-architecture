# Web Application AWS Architecture with Terraform

### What it does:

- Creates VPC with Internet Gateway, NAT Gateway, two Public subnets and one private Subnet.
- Creates a bastian Host, and security group for bastian Host.
- Creates web instances in private subnets and initializes them with user_data script.
- The web instances are exposed with Application Load Balancer.
- RDS instance is generated.
- Modules are used to share configuration across environment.
