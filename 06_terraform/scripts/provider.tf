terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access-key}"
  secret_key = "${var.secret-key}"

  default_tags {
      tags = {
          Environment = "${var.environment}"
          Owner       = "${var.owner}"
          Project     = "${var.project}"
      }
  }
}
