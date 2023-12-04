# Create VPC
resource "aws_vpc" "aws_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(local.tags, {
    Name = local.vpc_name
  })
}

resource "aws_main_route_table_association" "main_route_table" {
  vpc_id         = aws_vpc.aws_vpc.id
  route_table_id = aws_route_table.public.id
}

# Create public subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.public_subnet_name}${count.index + 1}"
  })
}

# Create private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.private_subnet_name}${count.index + 1}"
  })
}

# Create database subnets
resource "aws_subnet" "db" {
  count             = length(var.db_subnet)
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.db_subnet[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.db_subnet_name}${count.index + 1}"
  })
}

# Create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = merge(local.tags, {
    Name = local.public_rtb_name 
  })
}

# Create private subnet route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

/*
  route {
    cidr_block                = var.vpc_cidr
    vpc_peering_connection_id = data.aws_vpc_peering_connection.pc.id
  }
*/
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = merge(local.tags, {
    Name = local.private_rtb_name 
  })
}

# Create database route table
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = merge(local.tags, {
    Name = local.db_rtb_name
  })
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Associate db subnets with the db subnet route table
resource "aws_route_table_association" "db" {
  count          = length(aws_subnet.db)
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}

# Create NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.aws_eip.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_eip.aws_eip,
    aws_internet_gateway.igw
  ]
  tags = merge(local.tags, {
    Name = local.nat_gw_name
  })
}

# Create EIP for NAT gateway
resource "aws_eip" "aws_eip" {
  domain = "vpc"
  tags = merge(local.tags, {
    Name = local.eip_name
  })
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id

  tags = merge(local.tags, {
    Name = local.igw_name
  })
}






