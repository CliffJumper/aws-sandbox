terraform {
  required_version = "~> 1.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  # Configuration options
  region = var.region
  default_tags {
    tags = {
      Project = "EC2 Nonstandard SSH Port Example"
      nukable = "true"
    }
  }
}
