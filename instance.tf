resource "aws_key_pair" "mykeyss" {
  key_name   = "mykeyss"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}


resource "aws_instance" "Lab" {
  
  count            = var.instance_count
  ami              = var.ami
  instance_type    = var.instance_type
  key_name      = aws_key_pair.mykeyss.key_name


provisioner "file" {
  source = "script.sh"
  destination = "/tmp/script.sh"
  
}

provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/script.sh",
    "sudo /tmp/script.sh"
    ]
  }
  
connection {
  host        = self.public_ip
  user        = var.INSTANCE_USERNAME
  private_key = file(var.PATH_TO_PRIVATE_KEY)
  
}

  tags = {
    Name = "KubeLab"
  }
}



resource "aws_elb" "my-elb" {
  name            = "my-elb"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:6443/"
    interval            = 30
  }
  instances           = ["${aws_instance.Lab[0].id}", "${aws_instance.Lab[1].id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "kubernetes.io/cluster/kubernetes"
  }

}


