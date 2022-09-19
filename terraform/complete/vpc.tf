### creating vpc my-vpc


resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/26"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "my-vpc"
  }
}

##### aws internet gate way

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = merge(
    local.tags,{
      Name = "my-vpc-igw"
    })
}

#creating elastic ip
resource "aws_eip" "nat-eip" {
  vpc=true
}

#### aws subnets public-sub and private-sub


resource "aws_subnet" "public-sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.0.0/28"
  availability_zone = "us-east-1a"
  enable_resource_name_dns_a_record_on_launch="true"
  map_public_ip_on_launch = "true"
  tags = merge(
    local.tags,
    {
      Name = "my_vpc-pub-sub"
    })
}


resource "aws_subnet" "private-sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.0.32/28"
  availability_zone = "us-east-1b"
  enable_resource_name_dns_a_record_on_launch="true"
  tags = merge(
    local.tags,
    {
      Name = "my_vpc-pvt-sub"
    })
}

### aws nat gateway

resource "aws_nat_gateway" "dev-nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.public-sub.id
  tags={
    Name="Nat Gateway"
  }
  depends_on = [aws_internet_gateway.my_vpc_igw]
}

###################### aws route tables and association

resource "aws_route_table" "my-pvt-rt" {
  vpc_id =aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-nat.id
  }
  tags =merge(
    local.tags,
    {
      Name="pvt-RT"
    })
}

resource "aws_route_table_association" "sub-pub" {
  subnet_id =aws_subnet.public-sub.id
  route_table_id = aws_route_table.my-pub-rt.id
}
resource "aws_route_table_association" "sub-pvt" {
  subnet_id =aws_subnet.private-sub.id
  route_table_id = aws_route_table.my-pvt-rt.id
}
resource "aws_route_table" "my-pub-rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "pub-rt"
    })
}


