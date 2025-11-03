resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.project}-${var.env}-vpc" })
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "${var.project}-${var.env}-${each.key}" })
}


# PRIVATE SUBNETS
###########################
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    { Name = "${var.project}-${var.env}-${each.key}-private" }
  )
}



////intenet gateway?//////////



resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.project}-${var.env}-igw"
  })
  
}






///////Create Elastic IP for NAT Gateway?///


resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.project}-${var.env}-eip"
  })
}


#//////////////// Create NAT Gateway in first public subnet//////////////

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(values(aws_subnet.public), 0).id

  tags = merge(var.tags, {
    Name = "${var.project}-${var.env}-nat"
  })

  depends_on = [aws_internet_gateway.igw]
}



# //////////////////////////Public Route Table////////////////////////////////

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.project}-${var.env}-public-rt"
  })
}


/////////////////// Private Route Table//////////////////////////////////////////////

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(var.tags, {
    Name = "${var.project}-${var.env}-private-rt"
  })
}


#////////////////////////// Associate Subnets with Route Tables/////////////////////////

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}