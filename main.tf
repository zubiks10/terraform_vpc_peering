# Define provider
provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Update CIDR block as needed

  tags = {
    Name = "MainVPC"
  }
}

# Create subnets for each environment
resource "aws_subnet" "dev_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24" # Update CIDR block as needed
  availability_zone = "us-east-1a" # Change availability zone as needed

  tags = {
    Name = "DevSubnet"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24" # Update CIDR block as needed
  availability_zone = "us-east-1b" # Change availability zone as needed

  tags = {
    Name = "TestSubnet"
  }
}

resource "aws_subnet" "prod_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24" # Update CIDR block as needed
  availability_zone = "us-east-1c" # Change availability zone as needed

  tags = {
    Name = "ProdSubnet"
  }
}

# Create VPC Peering connections
resource "aws_vpc_peering_connection" "dev_to_prod" {
  provider = aws.us-west-2 # Change to the provider where Prod VPC is
  vpc_id   = aws_vpc.main.id
  peer_vpc_id = "prod_vpc_id_here" # Update with the Prod VPC ID
  auto_accept = true

  tags = {
    Name = "DevToProdPeering"
  }
}

resource "aws_vpc_peering_connection" "test_to_prod" {
  provider = aws.us-west-2 # Change to the provider where Prod VPC is
  vpc_id   = aws_vpc.main.id
  peer_vpc_id = "prod_vpc_id_here" # Update with the Prod VPC ID
  auto_accept = true

  tags = {
    Name = "TestToProdPeering"
  }
}

# Create routes for each environment
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.dev_to_prod.id
  }

  tags = {
    Name = "DevRouteTable"
  }
}

resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.test_to_prod.id
  }

  tags = {
    Name = "TestRouteTable"
  }
}

resource "aws_route_table" "prod_route_table" {
  vpc_id = "prod_vpc_id_here" # Update with the Prod VPC ID

  route {
    cidr_block = aws_vpc.main.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.dev_to_prod.id
  }

  route {
    cidr_block = aws_vpc.main.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.test_to_prod.id
  }

  tags = {
    Name = "ProdRouteTable"
  }
}
