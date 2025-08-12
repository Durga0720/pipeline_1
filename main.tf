terraform {
    backend "s3" {
      bucket = "mybucketdurga1"
      key = "backend/terraform.tfstate"
      region = "ap-south-1"
      
    }
    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>3.0"
     }
    }
} 
 

provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA6FTJR3YKRXBKOMGV"
    secret_key = "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"
}


resource "aws_instance" "my_server7" {
  ami                  = "ami-0144277607031eca2"
  instance_type        = "t2.micro"
  key_name             = "nwmumbaikey"
  availability_zone    = "ap-south-1b"
  hibernation          = true


  root_block_device {
    encrypted   = true
    volume_size = 10
  }


  tags = {
    Name = "mygoal"
  }

  
  ebs_block_device {
    device_name              = "/dev/sdb"
    volume_size              = 8
    encrypted                = true
    delete_on_termination    = true
  }


  provisioner "local-exec" { 
    command =  <<EOT
      sudo sleep 120 ;
      sudo ssh-keygen -R  $(self.public_ip);

      sudo ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i $(self.public_ip),playbook.yaml -u ec2-user--private-key /home/ec2-user/keys/nwmumbaikey
    EOT
  }
}
    

output "aws_attributes" {
    value = aws_instance.my_server7

}

