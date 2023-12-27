data "aws_vpc" "requester" {
  provider = aws.requester
  id       = var.requester_vpc_id
}

data "aws_vpc" "accepter" {
  provider = aws.accepter
  id       = var.accepter_vpc_id
}

data "aws_subnets" "requester" {
  provider = aws.requester

  filter {
    name   = "vpc-id"
    values = [var.requester_vpc_id]
  }

  tags = {
    Scheme = var.requester_subnet
  }
}

data "aws_subnet" "requester" {
  provider = aws.requester
  count    = length(data.aws_subnets.requester.ids)
  id       = tolist(data.aws_subnets.requester.ids)[count.index]
}

data "aws_subnets" "accepter_public" {
  provider = aws.accepter

  filter {
    name   = "vpc-id"
    values = [var.accepter_vpc_id]
  }

  tags = {
    Scheme = "public"
  }
}

data "aws_subnets" "accepter_private" {
  provider = aws.accepter

  filter {
    name   = "vpc-id"
    values = [var.accepter_vpc_id]
  }

  tags = {
    Scheme = "private"
  }
}

data "aws_subnets" "accepter_secure" {
  provider = aws.accepter
  filter {
    name   = "vpc-id"
    values = [var.accepter_vpc_id]

  }

  tags = {
    Scheme = "secure"
  }
}

data "aws_route_table" "accepter_public" {
  provider  = aws.accepter
  count     = length(data.aws_subnets.accepter_public.ids)
  subnet_id = tolist(data.aws_subnets.accepter_public.ids)[count.index]
}

data "aws_route_table" "accepter_private" {
  provider  = aws.accepter
  count     = length(data.aws_subnets.accepter_private.ids)
  subnet_id = tolist(data.aws_subnets.accepter_private.ids)[count.index]
}

data "aws_route_table" "accepter_secure" {
  provider  = aws.accepter
  count     = length(data.aws_subnets.accepter_secure.ids)
  subnet_id = tolist(data.aws_subnets.accepter_secure.ids)[count.index]
}

data "aws_route_table" "requester" {
  provider  = aws.requester
  count     = length(data.aws_subnets.requester.ids)
  subnet_id = tolist(data.aws_subnets.requester.ids)[count.index]
}

data "aws_network_acls" "accepter_public" {
  provider = aws.accepter
  vpc_id   = var.accepter_vpc_id

  tags = {
    Scheme = "public"
  }
}

data "aws_network_acls" "accepter_private" {
  provider = aws.accepter
  vpc_id   = var.accepter_vpc_id

  tags = {
    Scheme = "private"
  }
}

data "aws_network_acls" "accepter_secure" {
  provider = aws.accepter
  vpc_id   = var.accepter_vpc_id

  tags = {
    Scheme = "secure"
  }
}

data "aws_network_acls" "requester" {
  provider = aws.requester
  vpc_id   = var.requester_vpc_id

  tags = {
    Scheme = var.requester_subnet
  }
}
