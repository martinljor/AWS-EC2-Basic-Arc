variable "access_key" {
  description = "...Your KEY..."
}
variable "secret_key" {
  description = "...Your secret..."
}

variable "public_subnet" {
  type        = list(string)
  description = "Public Subnet"
  default     = ["172.16.1.0/24"]
}

variable "private_subnet" {
  type        = list(string)
  description = "Private Subnet"
  default     = ["172.16.2.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a"]
}