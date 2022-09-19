terraform {
    backend "s3" {
      bucket = "devops-tf-talent"
      dynamodb_table = "terraform-state-lock-dynamo"
      key    = "devops10/terraform.tfstate"
      region = "us-east-1"
    }
  }

