# --- root/locals.tf ---

locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security Group for Public Access"
      ingress = {
        open = {
          from        = 0
          to          = 0
          protocol    = -1
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        nginx = {
          from        = 8080
          to          = 8080
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
      tags = {
        name = "public-sg"
      }
    }
    rds = {
      name        = "rds_sg"
      description = "Security Group for RDS Access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
      tags = {
        name = "rds-sg"
      }
    }
  }
}

locals {
  target_groups = {
    squids_tg = {
      port     = 8080
      protocol = "HTTP"
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        interval            = 30
      }
    }
  }
}
