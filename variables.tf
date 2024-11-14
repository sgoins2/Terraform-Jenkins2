variable "instance-type" {
  type    = string
  default = "t2.micro"
}

variable "key-pair-name" {
  type    = string
  default = "HouseKey"
}

variable "ami-id" {
  type    = string
  default = "ami-0866a3c8686eaeeba"
}

variable "jenkins-security-group" {
  type    = string
  default = "jenkins-sg"
}

variable "jenkins-s3-bucket" {
  type    = string
  default = "jk-s3-111124"
}
