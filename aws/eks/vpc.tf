#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

# create a 10.0.0.0/16 VPC, two 10.0.X.0/24 subnets, an internet gateway
# setup the subnet routing to route external traffic through the internet gateway
resource "aws_vpc" "vpc_id" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = tomap({
    "Name" = "eks-vpc-${var.customer-name}-${var.cluster-name}",
    "kubernetes.io/cluster/${var.customer-name}-${var.cluster-name}" =  "shared"
    }
  )
}

resource "aws_subnet" "subnet_id" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id            = aws_vpc.vpc_id.id

  tags = tomap({
    "Name" = "eks-subnet-${var.customer-name}-${var.cluster-name}",
    "kubernetes.io/cluster/${var.customer-name}-${var.cluster-name}" = "shared",
    }
  )
}

resource "aws_internet_gateway" "gw_id" {
  vpc_id = aws_vpc.vpc_id.id

  tags = {
    Name =  "eks-internetgateway-${var.customer-name}-${var.cluster-name}",
  }
}

resource "aws_route_table" "route_id" {
  vpc_id = aws_vpc.vpc_id.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_id.id
  }
}

resource "aws_route_table_association" "route_table_id" {
  count = 2

  subnet_id      = aws_subnet.subnet_id.*.id[count.index]
  route_table_id = aws_route_table.route_id.id
}
