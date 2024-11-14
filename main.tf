#EC2 Instance Configuration

resource "aws_instance" "jenkins_instance" {
  ami                    = var.ami-id
  instance_type          = var.instance-type
  key_name               = var.key-pair-name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<-EOF
    #!/bin/bash

    # Update the package list
    
    sudo apt update -y

    # Install Java 17 (required for Jenkins) 
    
    sudo apt install -y fontconfig openjdk-17-jre

    # Verify Java installation
    
    java -version

    # Add the Jenkins repository key and source list
    
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

    # Update package list again to include Jenkins packages
    
    sudo apt update -y

    # Install Jenkins
    
    sudo apt install -y jenkins

    # Start Jenkins service
    
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  EOF
}

#Security Group Configuration

resource "aws_security_group" "jenkins_sg" {
  name = var.jenkins-security-group

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["149.102.242.219/32"] # Replace with your IP
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#S3 Bucket Configuration

resource "aws_s3_bucket" "jenkins_storage211124" {
  bucket = var.jenkins-s3-bucket

}


