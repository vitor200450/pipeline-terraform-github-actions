terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  backend "s3" {
    bucket = "josevitor-remote-state"
    key    = "aws-pipelines/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "josevitor"
      managed-by = "terraform"
    }
  }
}

# Acessar o state do VPC criado em outro diretório, para pegar os outputs da VPC
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "josevitor-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
