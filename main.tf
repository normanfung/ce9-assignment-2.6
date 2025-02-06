resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ami_linux.id #Challenge, find the AMI ID of Amazon Linux 2 in us-east-1
  instance_type               = var.ami_instance_type_t2_micro
  subnet_id                   = aws_subnet.public_subnets["public_subnet_1"].id #Public Subnet ID, e.g. subnet-xxxxxxxxxxx
  associate_public_ip_address = true
  key_name                    = var.key_pair #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids      = [aws_security_group.norman_security_group.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "norman-ec2-terraform" #Prefix your own name, e.g. jazeel-ec2
  }
}

output "ec2-instance" {
  value = aws_instance.ec2-instance.public_ip
}
