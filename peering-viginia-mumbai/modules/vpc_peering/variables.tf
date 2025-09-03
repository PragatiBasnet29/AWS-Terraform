variable "requester_vpc_id" {
  type = string
}

variable "accepter_vpc_id" {
  type = string
}

variable "accepter_region" {
  type = string
}

variable "auto_accept" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
