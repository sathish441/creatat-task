variable "vpc_region" {
 type = string
 default = "us-east-1"
}

variable "ec2_type" {
 type =string
 default= "t2.micro"
 validation {
 condition = substr(var.ec2_type,3,7)!="micro"
 error_message = " The instance type is not a micro"
}
}
