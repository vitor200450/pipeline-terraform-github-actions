resource "aws_key_pair" "key" {
  key_name   = "aws_key_pipelines"
  public_key = var.aws_key_pub
}

resource "aws_instance" "ec2" {
  ami                         = "ami-0b6d9d3d33ba97d99"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name       = "ec2_pipelines"
    Project    = "curso_terraform"
    CostCenter = "curso_terraform"
  }

  volume_tags = {
    Name       = "ec2_pipelines_volume"
    Project    = "curso_terraform"
    CostCenter = "curso_terraform"
  }
}
