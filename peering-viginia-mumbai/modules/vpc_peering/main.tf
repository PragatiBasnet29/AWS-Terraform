resource "aws_vpc_peering_connection" "this" {
  provider    = aws.requester
  vpc_id      = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  peer_region = var.accepter_region
  auto_accept = false
  tags        = var.tags
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = var.auto_accept
  tags                      = var.tags

  depends_on = [aws_vpc_peering_connection.this]
}
