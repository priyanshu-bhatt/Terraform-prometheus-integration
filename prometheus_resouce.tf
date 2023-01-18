resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "prometheus" {
  ami                    = "ami-08df646e18b182346"
  key_name               = aws_key_pair.webserver-key.key_name
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1a"
  vpc_security_group_ids = ["sg-0c65b045994aa27bb"]
  user_data              = <<EOF
		#!/bin/bash
		echo "******PROMETHEUS CONFIGURED********"          
#echo "*****Installing Prometheus in SERVER*********"
cd ~
wget https://github.com/prometheus/prometheus/releases/download/v2.37.0-rc.0/prometheus-2.37.0-rc.0.linux-amd64.tar.gz	
tar -xvf prometheus*
cd prometheus*
./prometheus --config.file=${var.config_file} 
		echo "******PROMETHEUS CONFIGURED********"
	EOF
 
  tags = {
    Name     = "Prometheus-Server"
    Team     = "Terraform"
    Location = "USA"
  }
}
resource "null_resource" "null_resource_simple" {
triggers= {
      mytrigger=timestamp()
}
connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host     = aws_instance.prometheus.public_ip
  }
 provisioner "file" {
    source      = "config_custom.yml"
    destination = "/tmp/config_custom.yml"
  }

#provisioner "file" {
    #source      = "script.sh"
   # destination = "/tmp/script.sh"
  #}




  
}
