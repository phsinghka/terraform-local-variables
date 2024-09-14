locals {
  region   = "us-east-2"
  vpc_cidr = "10.0.0.0/16"

  subnets = {
    public-1 = {
      cidr_block        = "10.0.1.0/24"
      type              = "public"
      availability_zone = "us-east-2a"
    }
    public-2 = {
      cidr_block        = "10.0.2.0/24"
      type              = "public"
      availability_zone = "us-east-2b"
    }
    private-1 = {
      cidr_block        = "10.0.3.0/24"
      type              = "private"
      availability_zone = "us-east-2a"
    }
    private-2 = {
      cidr_block        = "10.0.4.0/24"
      type              = "private"
      availability_zone = "us-east-2b"
    }
  }

  internet_cidr = "0.0.0.0/0"

  tags = {
    VPC              = "MainVPC"
    InternetGateway  = "MainIGW"
    PublicRouteTable = "PublicRouteTable"
  }
}

provider "aws" {
  region = local.region
}

resource "aws_vpc" "main_vpc" {
  cidr_block = local.vpc_cidr

  tags = {
    "Name" = local.tags["VPC"]
  }
}

resource "aws_subnet" "subnets" {
  for_each          = local.subnets
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    "Name" = "${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name" = local.tags["InternetGateway"]
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = local.internet_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = local.tags["PublicRouteTable"]
  }
}

resource "aws_route_table_association" "public_accoc" {
  for_each = { for key, subnet in aws_subnet.subnets : key => subnet if local.subnets[key].type == "public" }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}
