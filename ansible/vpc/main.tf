terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
#  profile = "default" # aws credential in $HOME/.aws/credentials
  region  = "us-east-1"
#  access_key = "xxxxxxxxx"
#  secret_key = "xxxxxxx"
}

resoruce "aws_vpc" "ansible-test-vpc"{
   cidr_block = "10.0.0.0/27"
   tags = {
    Name = "ansible-vpc"
}
}
