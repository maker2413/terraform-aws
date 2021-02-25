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

variable "key_name" {
  type    = string
  default = "squidskey"
}

variable "public_key_path" {
  type    = string
  default = "/home/epost/.ssh/squidskey.pub"
}

variable "tg_port" {
  type    = number
  default = 8080
}

variable "vol_size" {
  type    = number
  default = 10
}
