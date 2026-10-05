variable "location" {
  type    = string
  default = "Central India"
}
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "subnet_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
variable "adminuser" {
  type    = string
  default = "adminuser"
}
variable "vm_size" {
  type    = string
  default = "Standard_B2ls_v2"
}