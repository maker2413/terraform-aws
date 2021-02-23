# --- root/variables.tf ---

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "access_ip" {
  type = string
}

# --- database variables ---

variable "dbname" {
  type = string
}

variable "dbuser" {
  type      = string
  sensitive = true
}

variable "dbpassword" {
  type      = string
  sensitive = true
}

# --- computer variables ---
variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "vol_size" {
  type    = number
  default = 10
}
