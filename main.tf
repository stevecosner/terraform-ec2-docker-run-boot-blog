# Create ubuntu EC2 with ssh key, docker, docker-compose and run smcmrk/nginx-bootblog docker container containing Nginx and the bootstrap clean blog template.


provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-east-2"
}

resource "aws_instance" "webt1" {
  ami           = "ami-021b7b04f1ac696c2"
  instance_type = "t2.micro"
  key_name = "id_rsa_msa"
  

connection {
        user = "ubuntu"
        type = "ssh"
        private_key = "${file("~/.ssh/id_rsa_msa")}"
        timeout = "2m"
}
    provisioner "remote-exec" {
        inline = [
          "sleep 25",
          "sudo apt-get update",
          "sudo apt-get -y install docker-engine",
          "sudo apt-get -y install docker-compose",
          "sudo docker run -itd -p 80:80 smcmrk/nginx-bootblog"
    

        ]
   }


